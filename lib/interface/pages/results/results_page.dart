import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/interface/app/router/library/library_router.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─── Page ───────────────────────────────────────────────────────────────────────

/// Shows the results of the most recent installation session.
/// Muestra los resultados de la sesión de instalación más reciente.
class ResultsPage extends ConsumerWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(sessionResultsProvider);
    final textTheme = Theme.of(context).textTheme;

    final completed = items.where((i) => i.status == 'completed').length;
    final failed = items.where((i) => i.status == 'failed').length;
    final cancelled = items.where((i) => i.status == 'cancelled').length;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Resultados de instalación',
                    style: textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomElevatedButtonComponentShared.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withValues(alpha: .3),
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () => HomeRoute().go(context),
                  icon: const Icon(Icons.home_outlined),
                  label: const Text('Inicio'),
                ),
                const SizedBox(width: 10),
                CustomElevatedButtonComponentShared.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withValues(alpha: .5),
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () => HistoryPageLibraryRoute().go(context),
                  icon: const Icon(Icons.history),
                  label: const Text('Ver historial'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Session summary cards ─────────────────────────────────────────
            if (items.isNotEmpty)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _StatCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.greenAccent,
                    label: 'Instalados',
                    value: completed.toString(),
                  ),
                  _StatCard(
                    icon: Icons.error_outline,
                    iconColor: Colors.redAccent,
                    label: 'Fallidos',
                    value: failed.toString(),
                  ),
                  _StatCard(
                    icon: Icons.cancel_outlined,
                    iconColor: Colors.orangeAccent,
                    label: 'Cancelados',
                    value: cancelled.toString(),
                  ),
                  _StatCard(
                    icon: Icons.percent,
                    iconColor: Colors.blueAccent,
                    label: 'Tasa de éxito',
                    value: items.isEmpty
                        ? '—'
                        : '${(completed / items.length * 100).toStringAsFixed(1)}%',
                  ),
                ],
              ),

            const SizedBox(height: 24),

            Text(
              'Esta sesión',
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // ── Session items list ────────────────────────────────────────────
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.inbox_outlined,
                            color: Colors.white38,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No hay resultados de sesión disponibles.',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.white54),
                          ),
                          const SizedBox(height: 6),
                          TextButton.icon(
                            onPressed: () =>
                                HistoryPageLibraryRoute().go(context),
                            icon: const Icon(
                              Icons.history,
                              color: Colors.white54,
                            ),
                            label: const Text(
                              'Ver historial completo',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) =>
                          _SessionItem(item: items[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat card ─────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Session item card ─────────────────────────────────────────────────────────

class _SessionItem extends StatelessWidget {
  final QueueItemDataRule item;
  const _SessionItem({required this.item});

  Color _statusColor(String status) => switch (status) {
        'completed' => Colors.greenAccent,
        'failed' => Colors.redAccent,
        'cancelled' => Colors.orangeAccent,
        'paused' => Colors.blueAccent,
        _ => Colors.white54,
      };

  IconData _statusIcon(String status) => switch (status) {
        'completed' => Icons.check_circle,
        'failed' => Icons.cancel,
        'cancelled' => Icons.remove_circle,
        'paused' => Icons.pause_circle,
        _ => Icons.help_outline,
      };

  String _statusLabel(String status) => switch (status) {
        'completed' => 'Completado',
        'failed' => 'Fallido',
        'cancelled' => 'Cancelado',
        'paused' => 'Pausado',
        'installing' => 'Instalando',
        'queued' => 'En cola',
        _ => status,
      };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _statusColor(item.status);

    return Card(
      color: Colors.white.withValues(alpha: 0.07),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(_statusIcon(item.status), color: color, size: 28),
        title: Text(
          item.displayName,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          _statusLabel(item.status),
          style: textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
