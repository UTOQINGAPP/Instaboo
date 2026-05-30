import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/layouts/library/components/components_library.dart';
import 'package:instaboo/interface/pages/installing/logic/logic_installing_page.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

class InstallerPage extends ConsumerStatefulWidget {
  const InstallerPage({super.key});

  @override
  ConsumerState<InstallerPage> createState() => _InstallerPageState();
}

class _InstallerPageState extends ConsumerState<InstallerPage> {
  /// Selected software IDs.
  /// IDs de software seleccionados.
  final Set<int> _selectedIds = {};

  /// Whether a queuing operation is in progress (show spinner, block UI).
  /// Si hay una operación de encolado en curso (muestra spinner, bloquea UI).
  bool _isQueuing = false;

  // ── Helpers ──────────────────────────────────────────────────────────────────

  /// Returns the logo path for a software item: icon file if available, else asset fallback.
  /// Devuelve la ruta del logo: archivo de icono si existe, si no el asset por defecto.
  String _logoPath(SoftwareDataRule sw) {
    final icon = sw.iconFilename;
    if (icon != null && icon.isNotEmpty) {
      return FilesystemInfra.instance.getIconPath(icon);
    }
    return AssetsConfig.logo;
  }

  // ── Actions ───────────────────────────────────────────────────────────────────

  Future<void> _startInstallation() async {
    if (_selectedIds.isEmpty || _isQueuing) return;
    setState(() => _isQueuing = true);

    final consumer = ref.read(installationConsumerInjectionProvider);
    for (final softwareId in _selectedIds) {
      await consumer.queueSoftware(softwareId);
    }

    if (!mounted) return;
    // Reset the installing notifier so it rebuilds and processes the current
    // queue instead of reusing a previous finished session's state.
    // Reinicia el notifier de instalación para que se reconstruya y procese la
    // cola actual en vez de reusar el estado de una sesión anterior ya terminada.
    ref.invalidate(installingPageLogicProvider);
    // Navigate to the installing screen; it will pick up the queued items.
    // Navega a la pantalla de instalación; ella tomará los items encolados.
    InstallingRoute().go(context);
  }

  // ── Build ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final softwareAsync = ref.watch(softwareLogicSharedProvider);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          _buildHeader(context, textTheme),
          const Divider(height: 1, color: Colors.white12),
          Expanded(child: _buildList(softwareAsync, textTheme)),
          _buildFooter(context, textTheme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          CustomElevatedButtonComponentShared.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.white.withValues(alpha: .3),
              ),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            onPressed: () => HomeRoute().go(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Volver'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seleccionar software',
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Marca los programas que deseas instalar.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          if (_selectedIds.isNotEmpty) ...[
            const SizedBox(width: 12),
            _SelectionBadge(count: _selectedIds.length),
          ],
        ],
      ),
    );
  }

  Widget _buildList(
    AsyncValue<SoftwareStateShared> softwareAsync,
    TextTheme textTheme,
  ) {
    return softwareAsync.when(
      data: (state) {
        final list =
            state.softwareList.where((sw) => sw.isActive).toList();

        if (list.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.inbox_outlined,
                    color: Colors.white54, size: 48),
                const SizedBox(height: 12),
                Text(
                  'No hay software activo en la biblioteca.\nAgrega software desde la Biblioteca primero.',
                  textAlign: TextAlign.center,
                  style:
                      textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final sw = list[index];
            final hasInstaller =
                sw.installerId != null && sw.installerId!.isNotEmpty;
            final isSelected = _selectedIds.contains(sw.id);

            return Opacity(
              opacity: hasInstaller ? 1.0 : 0.45,
              child: ItemSoftwareComponentLibrary(
                logoPath: _logoPath(sw),
                name: sw.name,
                description: hasInstaller
                    ? (sw.description ?? '')
                    : '${sw.description?.isNotEmpty == true ? '${sw.description!}  •  ' : ''}Sin instalador asociado',
                categories: [],
                isEditableAndDeletable: false,
                isSelectable: true,
                value: isSelected,
                onChanged: hasInstaller
                    ? (value) => setState(() {
                          if (value) {
                            _selectedIds.add(sw.id);
                          } else {
                            _selectedIds.remove(sw.id);
                          }
                        })
                    : null,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Text(
          'Error al cargar software: $err',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_selectedIds.isNotEmpty)
            TextButton(
              onPressed:
                  _isQueuing ? null : () => setState(() => _selectedIds.clear()),
              child: const Text(
                'Limpiar selección',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed:
                (_selectedIds.isEmpty || _isQueuing) ? null : _startInstallation,
            icon: _isQueuing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.play_arrow),
            label: Text(
              _isQueuing
                  ? 'Preparando...'
                  : 'Comenzar (${_selectedIds.length})',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Selection badge ──────────────────────────────────────────────────────────

class _SelectionBadge extends StatelessWidget {
  final int count;
  const _SelectionBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count seleccionado${count == 1 ? '' : 's'}',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
