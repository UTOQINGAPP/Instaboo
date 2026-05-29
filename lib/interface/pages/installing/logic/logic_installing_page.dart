import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

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
  Timer? _pollTimer;

  /// Number of workers currently running.
  /// Número de workers en ejecución actualmente.
  int _activeCount = 0;

  /// Maximum simultaneous installations (from `parallel_installs` setting).
  /// Máximo de instalaciones simultáneas (de la configuración `parallel_installs`).
  int _maxParallel = 1;

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
    ref.onDispose(() {
      _disposed = true;
      _pollTimer?.cancel();
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

    final consumer = ref.read(installationConsumerInjectionProvider);

    // 1. Move all pending items → queued, assigning queue positions.
    await consumer.enqueuePending();

    // 2. Load initial queue snapshot.
    final items = await _fetchQueue();

    // 3. Start UI polling.
    _startPolling();

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

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      if (_disposed) return;
      final items = await _fetchQueue();
      if (_disposed) return;
      final isDone = _computeIsDone(items);
      if (state.hasValue) {
        state = AsyncData(
          state.value!.copyWith(items: items, isDone: isDone),
        );
        if (isDone) {
          _pollTimer?.cancel();
          _publishSessionSnapshot(items);
        }
      }
    });
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
      _sessionSnapshot.add(item.copyWith(status: 'failed'));
      await consumer.failInstallation(
        item.id,
        'No hay instalador asociado a este software.',
      );
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

      final stderrBuffer = StringBuffer();
      process.stderr.listen(
        (bytes) => stderrBuffer.write(String.fromCharCodes(bytes)),
      );

      final exitCode = await process.exitCode;
      _activeProcesses.remove(item.id);

      if (_disposed) return;

      // If killed intentionally (cancel/pause), DB already updated — skip.
      if (_killedItems.remove(item.id)) return;

      if (exitCode == 0) {
        // Record BEFORE delete: completeInstallation removes from queue.
        _sessionSnapshot.add(item.copyWith(status: 'completed'));
        await consumer.completeInstallation(item.id);
      } else {
        final stderr = stderrBuffer.toString();
        final detail = stderr.isNotEmpty
            ? 'Código de salida: $exitCode\n$stderr'
            : 'Código de salida: $exitCode';
        // Record BEFORE delete: failInstallation removes from queue.
        _sessionSnapshot.add(item.copyWith(status: 'failed'));
        await consumer.failInstallation(item.id, detail);
      }
    } catch (e) {
      _activeProcesses.remove(item.id);
      if (_disposed) return;
      if (_killedItems.remove(item.id)) return;
      _sessionSnapshot.add(item.copyWith(status: 'failed'));
      await consumer.failInstallation(item.id, e.toString());
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
    _pollTimer?.cancel();
    state = AsyncData(
      state.value!.copyWith(items: items, isDone: true, isPaused: true),
    );
    _publishSessionSnapshot(items);
  }
}

// ─── Provider ─────────────────────────────────────────────────────────────────

/// Provider for [InstallingPageLogic].
final installingPageLogicProvider =
    AsyncNotifierProvider<InstallingPageLogic, InstallingPageState>(
  InstallingPageLogic.new,
);
