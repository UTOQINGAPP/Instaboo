import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/layouts/library/pages/packages/dialogs/dialogs_packages_library.dart';
import 'package:instaboo/interface/layouts/library/pages/packages/logic/logic_packages_library.dart';
import 'package:instaboo/interface/pages/installing/logic/logic_installing_page.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

class PackagesPageLibrary extends ConsumerWidget {
  const PackagesPageLibrary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logic = ref.watch(packagesLogicLibraryProvider);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────────
            ListTile(
              title: Text(
                'Gestionar Paquetes',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Agrupa software en paquetes para instalaciones en lote.',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: CustomElevatedButtonComponentShared.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white.withValues(alpha: .5),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () => _showPackDialog(context, pack: null),
                icon: const Icon(Icons.add),
                label: const Text('Nuevo Paquete'),
              ),
            ),

            const SizedBox(height: 20),

            // ── List ──────────────────────────────────────────────────────────
            Expanded(
              child: logic.when(
                data: (state) {
                  // Show error banner if any, but still render list if available.
                  // Muestra banner de error si aplica, pero renderiza la lista si hay datos.
                  return Column(
                    children: [
                      if (state.errorMessage != null)
                        _ErrorBanner(
                          message: state.errorMessage!,
                          onDismiss: () => ref
                              .read(packagesLogicLibraryProvider.notifier)
                              .clearError(),
                        ),
                      Expanded(
                        child: state.packsList.isEmpty
                            ? const Center(
                                child: Text(
                                  'No hay paquetes creados.\nUsa el botón de arriba para crear uno.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                itemCount: state.packsList.length,
                                itemBuilder: (context, index) {
                                  final pack = state.packsList[index];
                                  return _PackItemCard(
                                    pack: pack,
                                    onEdit: () =>
                                        _showPackDialog(context, pack: pack),
                                    onDelete: () =>
                                        _confirmDelete(context, ref, pack),
                                    onInstall: () =>
                                        _installPack(context, ref, pack),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Error: $err',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () =>
                            ref.read(packagesLogicLibraryProvider.notifier).load(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPackDialog(BuildContext context, {PackDataRule? pack}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, _, _) => AddPackDialogLibrary(pack: pack),
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _installPack(
    BuildContext context,
    WidgetRef ref,
    PackDataRule pack,
  ) async {
    final consumer = ref.read(installationConsumerInjectionProvider);
    await consumer.queuePack(pack.id);
    if (!context.mounted) return;
    // Reset the installing notifier so it processes this queue, not a stale one.
    // Reinicia el notifier de instalación para que procese esta cola, no una vieja.
    ref.invalidate(installingPageLogicProvider);
    InstallingRoute().go(context);
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    PackDataRule pack,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar paquete'),
        content: Text(
          '¿Eliminar "${pack.name}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(packagesLogicLibraryProvider.notifier)
          .deletePack(pack.id);
    }
  }
}

// ─── Pack item card ────────────────────────────────────────────────────────────

class _PackItemCard extends StatelessWidget {
  final PackDataRule pack;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onInstall;

  const _PackItemCard({
    required this.pack,
    required this.onEdit,
    required this.onDelete,
    required this.onInstall,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white.withValues(alpha: 0.1),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              pack.icon?.isNotEmpty == true ? pack.icon! : '📦',
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
        title: Text(
          pack.name,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: pack.description != null
            ? Text(
                pack.description!,
                style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButtonComponentShared.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.green.withValues(alpha: .7),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: onInstall,
              icon: const Icon(Icons.download_for_offline, size: 18),
              label: const Text('Instalar'),
            ),
            const SizedBox(width: 8),
            CustomElevatedButtonComponentShared(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.white.withValues(alpha: .5),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: onEdit,
              child: const Icon(Icons.edit),
            ),
            const SizedBox(width: 8),
            CustomElevatedButtonComponentShared(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.white.withValues(alpha: .5),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: onDelete,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Error banner ──────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorBanner({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white54, size: 18),
            onPressed: onDismiss,
            tooltip: 'Cerrar',
          ),
        ],
      ),
    );
  }
}
