import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/pages/installing/logic/logic_installing_page.dart';

class InstallingPage extends ConsumerWidget {
  const InstallingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(installingPageLogicProvider);
    final textTheme = Theme.of(context).textTheme;

    // Auto-navigate to results when all installations finish (not paused).
    // Navega automáticamente a resultados al terminar todas las instalaciones.
    ref.listen<AsyncValue<InstallingPageState>>(
      installingPageLogicProvider,
      (previous, next) {
        final prev = previous?.value;
        final curr = next.value;
        if (curr == null) return;
        final wasNotDone = prev == null || !prev.isDone;
        if (wasNotDone && curr.isDone && !curr.isPaused) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) ResultsRoute().go(context);
          });
        }
      },
    );

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            _buildHeader(context, textTheme, asyncState, ref),

            const SizedBox(height: 24),

            // ── Queue list ───────────────────────────────────────────────────
            Expanded(child: _buildBody(context, textTheme, asyncState, ref)),

            // ── Footer ───────────────────────────────────────────────────────
            _buildFooter(context, asyncState, ref),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader(
    BuildContext context,
    TextTheme textTheme,
    AsyncValue<InstallingPageState> asyncState,
    WidgetRef ref,
  ) {
    final isDone = asyncState.value?.isDone ?? false;
    final isPaused = asyncState.value?.isPaused ?? false;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDone
                    ? (isPaused ? 'Instalación pausada' : 'Instalación completada')
                    : 'Instalando software…',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isDone
                    ? 'Puedes revisar los resultados o volver al inicio.'
                    : 'No cierres la aplicación mientras se instala.',
                style:
                    textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
        if (!isDone && asyncState.hasValue)
          TextButton.icon(
            onPressed: () =>
                ref.read(installingPageLogicProvider.notifier).pauseAll(),
            icon: const Icon(Icons.pause, color: Colors.white70),
            label: const Text(
              'Pausar todo',
              style: TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }

  // ── Body ────────────────────────────────────────────────────────────────────

  Widget _buildBody(
    BuildContext context,
    TextTheme textTheme,
    AsyncValue<InstallingPageState> asyncState,
    WidgetRef ref,
  ) {
    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 12),
            Text(
              'Error al iniciar instalación:\n$err',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      data: (state) {
        if (state.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.inbox_outlined, color: Colors.white54, size: 48),
                SizedBox(height: 12),
                Text(
                  'No hay items en la cola.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final item = state.items[index];
            return _QueueItemCard(
              item: item,
              onCancel: _canCancel(item.status)
                  ? () => ref
                      .read(installingPageLogicProvider.notifier)
                      .cancelItem(item.id)
                  : null,
            );
          },
        );
      },
    );
  }

  // ── Footer ──────────────────────────────────────────────────────────────────

  Widget _buildFooter(
    BuildContext context,
    AsyncValue<InstallingPageState> asyncState,
    WidgetRef ref,
  ) {
    final isDone = asyncState.value?.isDone ?? false;
    if (!isDone) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton.icon(
            onPressed: () => HomeRoute().go(context),
            icon: const Icon(Icons.home_outlined, color: Colors.white70),
            label: const Text(
              'Inicio',
              style: TextStyle(color: Colors.white70),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white24),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: () => ResultsRoute().go(context),
            icon: const Icon(Icons.bar_chart),
            label: const Text('Ver resultados'),
          ),
        ],
      ),
    );
  }

  bool _canCancel(String status) =>
      status == 'pending' || status == 'queued' || status == 'installing';
}

// ─── Queue item card ──────────────────────────────────────────────────────────

class _QueueItemCard extends StatefulWidget {
  final QueueItemDataRule item;
  final VoidCallback? onCancel;

  const _QueueItemCard({required this.item, this.onCancel});

  @override
  State<_QueueItemCard> createState() => _QueueItemCardState();
}

class _QueueItemCardState extends State<_QueueItemCard> {
  Timer? _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    if (widget.item.status == 'installing') _startTicker();
  }

  @override
  void didUpdateWidget(_QueueItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.status == 'installing' &&
        oldWidget.item.status != 'installing') {
      _updateElapsed();
      _startTicker();
    } else if (widget.item.status != 'installing') {
      _ticker?.cancel();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(_updateElapsed);
    });
  }

  void _updateElapsed() {
    final started = widget.item.startedAt;
    _elapsed = started != null
        ? DateTime.now().difference(started)
        : Duration.zero;
  }

  String _formatElapsed(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Color _statusColor() => switch (widget.item.status) {
        'installing' => Colors.blueAccent,
        'cancelled' => Colors.orangeAccent,
        'paused' => Colors.white38,
        'queued' => Colors.white60,
        _ => Colors.white38, // pending
      };

  IconData _statusIcon() => switch (widget.item.status) {
        'installing' => Icons.downloading,
        'cancelled' => Icons.cancel_outlined,
        'paused' => Icons.pause_circle_outline,
        'queued' => Icons.hourglass_top,
        _ => Icons.schedule, // pending
      };

  String _statusLabel() => switch (widget.item.status) {
        'installing' => 'Instalando',
        'cancelled' => 'Cancelado',
        'paused' => 'Pausado',
        'queued' => 'En cola',
        _ => 'Pendiente',
      };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _statusColor();
    final isInstalling = widget.item.status == 'installing';

    return Card(
      color: Colors.white.withValues(alpha: 0.07),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Status icon
                Icon(_statusIcon(), color: color, size: 26),
                const SizedBox(width: 12),

                // Name + status + elapsed
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.displayName,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _statusLabel(),
                            style: textTheme.bodySmall?.copyWith(color: color),
                          ),
                          // Elapsed timer shown while installing (UX-05)
                          if (isInstalling && _elapsed > Duration.zero) ...[
                            Text(
                              '  •  ${_formatElapsed(_elapsed)}',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.white54),
                            ),
                          ],
                          if (widget.item.queuePosition != null &&
                              !isInstalling) ...[
                            Text(
                              '  •  Posición ${widget.item.queuePosition}',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.white38),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Cancel button
                if (onCancel != null)
                  IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close, size: 18),
                    color: Colors.white54,
                    tooltip: 'Cancelar',
                  ),
              ],
            ),

            // Indeterminate progress bar while installing (UX-05)
            if (isInstalling) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: widget.item.progress > 0
                      ? widget.item.progress / 100
                      : null, // null = indeterminate
                  minHeight: 5,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],

            // Error details when cancelled / failed
            if (widget.item.errorMessage != null &&
                widget.item.errorMessage!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                widget.item.errorMessage!,
                style: textTheme.bodySmall?.copyWith(
                    color: Colors.redAccent.withValues(alpha: 0.9)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  VoidCallback? get onCancel => widget.onCancel;
}
