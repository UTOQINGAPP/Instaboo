import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:local_notifier/local_notifier.dart';

// ─── State ────────────────────────────────────────────────────────────────────

/// UI state for the installing page.
/// Estado de UI para la página de instalación.
final class InstallingPageState {
  /// All items currently in the queue (any status).
  /// Todos los items actualmente en la cola (cualquier estado).
  final List<QueueItemDataRule> items;

  /// True when no more items are pending, queued, or actively installing.
  /// Verdadero cuando no quedan items pendientes, encolados o instalando.
  final bool isDone;

  /// True while the queue was paused by the user.
  /// Verdadero mientras el usuario pausó la cola.
  final bool isPaused;

  const InstallingPageState({
    required this.items,
    this.isDone = false,
    this.isPaused = false,
  });

  InstallingPageState copyWith({
    List<QueueItemDataRule>? items,
    bool? isDone,
    bool? isPaused,
  }) =>
      InstallingPageState(
        items: items ?? this.items,
        isDone: isDone ?? this.isDone,
        isPaused: isPaused ?? this.isPaused,
      );
}

// ─── Logic ────────────────────────────────────────────────────────────────────

/// Notifier that drives the real-time installation flow.
///
/// Lifecycle:
///   build() → enqueuePending → _processNext × _maxParallel → polling
///
/// Parallel support: reads `parallel_installs` from settings on build and
/// launches up to that many concurrent OS processes. Each worker calls
/// [_processNext] again when it finishes so the pool stays full.
///
/// Notifier que maneja el flujo de instalación en tiempo real con soporte
/// de instalaciones en paralelo.
class InstallingPageLogic extends AsyncNotifier<InstallingPageState> {
  StreamSubscription<List<QueueItemDataRule>>? _queueSub;

  /// Number of workers currently running.
  /// Número de workers en ejecución actualmente.
  int _activeCount = 0;

  /// Running totals tracked directly in _runInstaller (used for the
  /// end-of-batch notification). More reliable than reading _sessionSnapshot
  /// at stream-emit time due to async interleaving.
  /// Conteos actualizados directamente en _runInstaller para la notificación
  /// de fin de lote. Más fiable que leer _sessionSnapshot en el evento del stream.
  int _completedCount = 0;
  int _failedCount = 0;

  /// Maximum simultaneous installations (from `parallel_installs` setting).
  /// Máximo de instalaciones simultáneas (de la configuración `parallel_installs`).
  int _maxParallel = 1;

  /// Per-installer timeout in minutes (from `install_timeout_minutes`).
  /// 0 disables the timeout entirely.
  /// Timeout por instalador en minutos (de `install_timeout_minutes`).
  /// 0 desactiva el timeout por completo.
  int _timeoutMinutes = 15;

  /// Set to true in onDispose so async callbacks don't touch dead state.
  /// Puesto a true en onDispose para que callbacks asincrónicos no toquen estado muerto.
  bool _disposed = false;

  /// Live process references keyed by queue item ID.
  /// Allows cancel/pause to kill the OS process mid-execution.
  /// Referencias vivas a procesos, indexadas por ID de item de cola.
  final Map<int, Process> _activeProcesses = {};

  /// Items whose process was killed intentionally (cancel/pause).
  /// _runInstaller skips reporting for these — the DB was already updated.
  /// Items cuyo proceso fue matado intencionalmente; _runInstaller omite el reporte.
  final Set<int> _killedItems = {};

  /// Accumulates items with their final statuses for the session results page.
  /// completeInstallation/failInstallation DELETE items from the queue, so we
  /// must record them here BEFORE those calls.
  /// Acumula items con sus estados finales para la página de resultados.
  final List<QueueItemDataRule> _sessionSnapshot = [];

  @override
  Future<InstallingPageState> build() async {
    // build() can re-run on the SAME notifier instance (e.g. after
    // ref.invalidate, since this provider is not autoDispose). Reset the
    // per-session state so a previous finished session doesn't leave
    // _disposed=true, stale counters, or an old snapshot behind.
    // build() puede re-ejecutarse sobre la MISMA instancia del notifier (p. ej.
    // tras ref.invalidate, al no ser autoDispose). Reinicia el estado de sesión
    // para que una sesión anterior no deje _disposed=true, contadores viejos ni
    // un snapshot previo.
    _disposed = false;
    _activeCount = 0;
    _completedCount = 0;
    _failedCount = 0;
    _queueSub?.cancel();
    _activeProcesses.clear();
    _killedItems.clear();
    _sessionSnapshot.clear();

    ref.onDispose(() {
      _disposed = true;
      _queueSub?.cancel();
      for (final process in _activeProcesses.values) {
        process.kill();
      }
      _activeProcesses.clear();
    });

    // Read parallel_installs setting (default 1 if not found or invalid).
    // Lee la configuración parallel_installs (default 1 si no existe o es inválida).
    final settingsConsumer = ref.read(settingsConsumerInjectionProvider);
    final parallelResp = await settingsConsumer.getInt('parallel_installs');
    _maxParallel = parallelResp.resolve(
      onSuccess: (v, _) => v.clamp(1, 10),
      onFailure: (_, _) => 1,
    );

    // Read install_timeout_minutes (default 15, 0 = disabled). Negative values
    // are treated as disabled.
    // Lee install_timeout_minutes (default 15, 0 = desactivado). Valores
    // negativos se tratan como desactivado.
    final timeoutResp =
        await settingsConsumer.getInt('install_timeout_minutes');
    _timeoutMinutes = timeoutResp.resolve(
      onSuccess: (v, _) => v < 0 ? 0 : v,
      onFailure: (_, _) => 15,
    );

    final consumer = ref.read(installationConsumerInjectionProvider);

    // 1. Move all pending items → queued, assigning queue positions.
    await consumer.enqueuePending();

    // 2. Load initial queue snapshot.
    final items = await _fetchQueue();

    // 3. Start reactive queue watch (replaces 2-second polling — UX-04).
    _startWatching();

    // 4. Launch up to _maxParallel workers concurrently (intentionally unawaited).
    //    Each _processNext() call reserves a slot, marks one item 'installing',
    //    and runs its installer. When it finishes it calls _processNext() again.
    for (var i = 0; i < _maxParallel; i++) {
      _processNext(); // unawaited — fire and forget
    }

    return InstallingPageState(
      items: items,
      isDone: _computeIsDone(items),
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  /// Publishes the session snapshot to [sessionResultsProvider].
  /// Merges items tracked internally (completed/failed, deleted from DB) with
  /// any live queue items (cancelled/paused, still in DB).
  void _publishSessionSnapshot(List<QueueItemDataRule> liveItems) {
    final trackedIds = _sessionSnapshot.map((i) => i.id).toSet();
    final combined = [
      ..._sessionSnapshot,
      ...liveItems.where((i) => !trackedIds.contains(i.id)),
    ];
    ref.read(sessionResultsProvider.notifier).setSnapshot(combined);
  }

  Future<List<QueueItemDataRule>> _fetchQueue() async {
    final consumer = ref.read(installationConsumerInjectionProvider);
    final resp = await consumer.getQueue();
    return resp.resolve(
      onSuccess: (data, _) => data,
      onFailure: (_, _) => <QueueItemDataRule>[],
    );
  }

  bool _computeIsDone(List<QueueItemDataRule> items) {
    if (items.isEmpty) return true;
    const terminalStatuses = {'completed', 'failed', 'cancelled', 'paused'};
    return items.every((i) => terminalStatuses.contains(i.status));
  }

  /// Subscribes to the Drift queue stream (UX-04). Replaces the 2-second
  /// polling timer with reactive updates pushed by the database layer.
  /// Se suscribe al stream de Drift (UX-04). Reemplaza el polling de 2s por
  /// actualizaciones reactivas empujadas por la capa de base de datos.
  void _startWatching() {
    final consumer = ref.read(installationConsumerInjectionProvider);
    _queueSub = consumer.watchQueue().listen((items) async {
      if (_disposed) return;
      final isDone = _computeIsDone(items);
      if (state.hasValue) {
        state = AsyncData(
          state.value!.copyWith(items: items, isDone: isDone),
        );
        if (isDone) {
          _queueSub?.cancel();
          _publishSessionSnapshot(items);
          // Use the session snapshot for the notification: live queue items
          // are deleted on complete/fail, so `items` may be empty by now.
          // Usamos el snapshot de sesión para la notificación: los items se
          // eliminan de la cola al completar/fallar, así que `items` puede
          // estar vacío en este punto.
          await _sendBatchNotification();
          // Invalidate the Windows registry cache so the library badges
          // reflect newly installed programs when the user navigates back.
          // Invalida el caché del registro de Windows para que los badges
          // de la biblioteca reflejen los programas recién instalados.
          WindowsRegistryInfra.invalidateCache();
          ref.invalidate(installedSoftwareProvider);
          // Sesión terminada: limpia la cola transitoria.
          await ref.read(installationConsumerInjectionProvider).clearQueue();
        }
      }
    });
  }

  /// Sends a Windows Toast notification when the batch finishes (UX-03 / NF-12).
  /// Uses [_completedCount] / [_failedCount] tracked directly in _runInstaller
  /// so the counts are always accurate regardless of stream timing.
  /// Respects the `notifications_enabled` setting — does nothing if disabled.
  Future<void> _sendBatchNotification() async {
    try {
      final settingsConsumer = ref.read(settingsConsumerInjectionProvider);
      final enabledResp =
          await settingsConsumer.getBool('notifications_enabled');
      final enabled = enabledResp.resolve(
        onSuccess: (v, _) => v,
        onFailure: (_, _) => true,
      );
      if (!enabled) return;

      final total = _completedCount + _failedCount;
      final String title;
      final String body;
      if (_failedCount == 0) {
        title = 'Instaboo — Instalación completada';
        body = '$_completedCount de $total programas instalados correctamente.';
      } else {
        title = 'Instaboo — Instalación finalizada con errores';
        body = '$_completedCount correctas, $_failedCount con error '
            '(total: $total).';
      }

      await localNotifier.notify(LocalNotification(title: title, body: body));
    } catch (_) {
      // Notification errors must never interrupt the installation flow.
      // Los errores de notificación no deben interrumpir el flujo.
    }
  }

  /// Attempts to start one more installer worker if below the concurrency limit.
  ///
  /// [_activeCount] is incremented BEFORE the first `await` so that concurrent
  /// calls (which interleave only at await points in Dart's single-threaded
  /// event loop) each see the correct updated count and don't over-schedule.
  ///
  /// Intenta iniciar un worker más si está por debajo del límite de concurrencia.
  Future<void> _processNext() async {
    if (_disposed) return;
    if (_activeCount >= _maxParallel) return;

    // Reserve a slot synchronously before the first await.
    // Reserva un slot de forma síncrona antes del primer await.
    _activeCount++;

    final consumer = ref.read(installationConsumerInjectionProvider);
    final resp = await consumer.startNextInstallation(_maxParallel);
    if (_disposed) {
      _activeCount--;
      return;
    }

    final itemId = resp.resolve(
      onSuccess: (id, _) => id,
      onFailure: (_, _) => null,
    );

    if (itemId == null) {
      // Queue empty or already at capacity — release slot.
      // Cola vacía o ya en capacidad — libera el slot.
      _activeCount--;
      return;
    }

    // Fetch the full item data to pass to the installer.
    // Obtiene los datos completos del item para pasarlos al instalador.
    final items = await _fetchQueue();
    if (_disposed) {
      _activeCount--;
      return;
    }

    final item = items
        .where((i) => i.id == itemId && i.status == 'installing')
        .firstOrNull;

    if (item == null) {
      _activeCount--;
      return;
    }

    // Run the installer and, when done, decrement the slot and try the next item.
    // Ejecuta el instalador y, al terminar, libera el slot e intenta el siguiente.
    _runInstaller(item).whenComplete(() {
      _activeCount--;
      if (!_disposed) {
        _processNext(); // unawaited — keeps the pool filled
      }
    });
  }

  /// Runs the installer executable for [item] and reports success or failure.
  /// Records the item in [_sessionSnapshot] BEFORE calling complete/fail,
  /// since those methods delete the item from the DB queue.
  /// Runs the installer executable for [item] and reports success or failure.
  Future<void> _runInstaller(QueueItemDataRule item) async {
    final consumer = ref.read(installationConsumerInjectionProvider);

    if (item.installerId == null || item.installerId!.isEmpty) {
      const msg = 'No hay instalador asociado a este software.';
      _failedCount++;
      _sessionSnapshot.add(item.copyWith(status: 'failed', errorMessage: msg));
      await consumer.failInstallation(item.id, msg);
      return;
    }

    try {
      final installersConsumer = ref.read(installersConsumerInjectionProvider);
      final installerResp =
          await installersConsumer.getById(item.installerId!);
      final installer = installerResp.resolve(
        onSuccess: (data, _) => data,
        onFailure: (msg, _) => throw Exception(msg),
      );

      final exePath = FilesystemInfra.instance.getInstallerExecutablePath(
        installer.id,
        installer.mainExecutable,
      );

      // Integrity pre-flight (SEC-02): never launch a binary whose on-disk
      // hash doesn't match its stored baseline.
      // Pre-vuelo de integridad (SEC-02): nunca lanzar un binario cuyo hash en
      // disco no coincida con su línea base.
      final integrityResp =
          await installersConsumer.checkIntegrity(installer.id);
      if (_disposed) return;
      final integrityError = integrityResp.resolve(
        onSuccess: (_, _) => null,
        onFailure: (msg, _) => msg,
      );
      if (integrityError != null) {
        _sessionSnapshot
            .add(item.copyWith(status: 'failed', errorMessage: integrityError));
        await consumer.failInstallation(item.id, integrityError);
        return;
      }

      List<String> args;
      if (item.softwareId != null) {
        final softwareConsumer = ref.read(softwareConsumerInjectionProvider);
        final softwareResp = await softwareConsumer.getById(item.softwareId!);
        final software = softwareResp.resolve(
          onSuccess: (data, _) => data,
          onFailure: (_, _) => null,
        );
        final isAutoInstallable = software?.isAutoInstallable ?? true;
        args = isAutoInstallable
            ? (installer.silentArgs
                    ?.split(' ')
                    .where((s) => s.isNotEmpty)
                    .toList() ??
                <String>[])
            : <String>[];
      } else {
        args = installer.silentArgs
                ?.split(' ')
                .where((s) => s.isNotEmpty)
                .toList() ??
            <String>[];
      }

      final workingDir = File(exePath).parent.path;
      final process = await Process.start(
        exePath,
        args,
        workingDirectory: workingDir,
        runInShell: false,
      );
      _activeProcesses[item.id] = process;

      // Drain BOTH streams (BUG-03) and decode them properly later (BUG-02).
      // An undrained stdout pipe can fill its buffer and stall the process.
      // Drena AMBOS flujos (BUG-03) y los decodifica correctamente luego (BUG-02).
      // Un stdout sin drenar puede llenar su búfer y bloquear el proceso.
      final stdoutFuture = process.stdout
          .fold<List<int>>(<int>[], (acc, bytes) => acc..addAll(bytes))
          .catchError((_) => <int>[]);
      final stderrFuture = process.stderr
          .fold<List<int>>(<int>[], (acc, bytes) => acc..addAll(bytes))
          .catchError((_) => <int>[]);

      // Wait for the installer, applying a timeout when configured (BUG-04).
      // A hung installer would otherwise hold its worker forever.
      // Espera al instalador aplicando un timeout si está configurado (BUG-04).
      // Un instalador colgado, si no, ocuparía su worker para siempre.
      int exitCode;
      var timedOut = false;
      if (_timeoutMinutes > 0) {
        try {
          exitCode = await process.exitCode
              .timeout(Duration(minutes: _timeoutMinutes));
        } on TimeoutException {
          timedOut = true;
          process.kill();
          exitCode = -1;
        }
      } else {
        exitCode = await process.exitCode;
      }
      _activeProcesses.remove(item.id);

      if (_disposed) return;

      // If killed intentionally (cancel/pause), DB already updated — skip.
      if (_killedItems.remove(item.id)) return;

      // Timed out: the process was killed above; report it as failed.
      // Timeout agotado: el proceso fue terminado arriba; se reporta como fallido.
      if (timedOut) {
        final msg = 'Tiempo de espera agotado tras $_timeoutMinutes min. '
            'El proceso del instalador fue terminado.';
        _failedCount++;
        _sessionSnapshot.add(item.copyWith(status: 'failed', errorMessage: msg));
        await consumer.failInstallation(item.id, msg);
        return;
      }

      if (exitCode == 0) {
        _completedCount++;
        _sessionSnapshot.add(item.copyWith(status: 'completed'));
        await consumer.completeInstallation(item.id);
      } else {
        final err = _decodeProcessOutput(await stderrFuture);
        final out = _decodeProcessOutput(await stdoutFuture);
        final parts = <String>['Código de salida: $exitCode'];
        if (err.isNotEmpty) {
          parts.add(err);
        } else if (out.isNotEmpty) {
          parts.add(out);
        }
        final detail = parts.join('\n');
        _failedCount++;
        _sessionSnapshot
            .add(item.copyWith(status: 'failed', errorMessage: detail));
        await consumer.failInstallation(item.id, detail);
      }
    } catch (e) {
      _activeProcesses.remove(item.id);
      if (_disposed) return;
      if (_killedItems.remove(item.id)) return;
      final msg = e.toString();
      _failedCount++;
      _sessionSnapshot.add(item.copyWith(status: 'failed', errorMessage: msg));
      await consumer.failInstallation(item.id, msg);
    }
  }

  /// Decodes installer output bytes with the OS encoding, falling back to raw
  /// code units if decoding fails (BUG-02). Avoids mangling accented messages.
  /// Decodifica bytes de salida con la codificación del SO; si falla, usa los
  /// code units crudos (BUG-02). Evita corromper mensajes con acentos.
  String _decodeProcessOutput(List<int> bytes) {
    if (bytes.isEmpty) return '';
    try {
      return systemEncoding.decode(bytes).trim();
    } catch (_) {
      return String.fromCharCodes(bytes).trim();
    }
  }

  // ── Public actions ─────────────────────────────────────────────────────────

  /// Cancels a single queue item, killing its process if currently running.
  Future<void> cancelItem(int queueItemId) async {
    final process = _activeProcesses[queueItemId];
    if (process != null) {
      _killedItems.add(queueItemId);
      process.kill();
    }

    final consumer = ref.read(installationConsumerInjectionProvider);
    await consumer.cancelQueueItem(queueItemId);
    if (_disposed) return;
    final items = await _fetchQueue();
    if (_disposed || !state.hasValue) return;
    state = AsyncData(
      state.value!.copyWith(items: items, isDone: _computeIsDone(items)),
    );
  }

  /// Pauses the entire queue, killing all running processes immediately.
  Future<void> pauseAll() async {
    for (final entry in _activeProcesses.entries) {
      _killedItems.add(entry.key);
      entry.value.kill();
    }
    _activeProcesses.clear();

    final consumer = ref.read(installationConsumerInjectionProvider);
    await consumer.pauseQueue();
    if (_disposed) return;
    final items = await _fetchQueue();
    if (_disposed || !state.hasValue) return;
    _queueSub?.cancel();
    state = AsyncData(
      state.value!.copyWith(items: items, isDone: true, isPaused: true),
    );
    _publishSessionSnapshot(items);
    // Clear the transient queue after pausing too; the snapshot already holds
    // what results needs.
    // Limpia la cola transitoria también al pausar; el snapshot ya tiene lo
    // que necesitan los resultados.
    await consumer.clearQueue();
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

/// Provider for [InstallingPageLogic].
final installingPageLogicProvider =
    AsyncNotifierProvider<InstallingPageLogic, InstallingPageState>(
  InstallingPageLogic.new,
);
