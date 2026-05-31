import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:instaboo/interface/pages/installer/logic/installer_page_logic.dart';

/// Left-panel sidebar for the installer page.
/// Shows: All, Software (by category), Packages.
///
/// Panel lateral izquierdo de la página del instalador.
/// Muestra: Todos, Software (por categoría), Paquetes.
class InstallerSidebar extends ConsumerWidget {
  const InstallerSidebar({
    super.key,
    required this.currentMode,
    required this.selectedCategoryId,
    required this.selectedPackId,
  });

  final InstallerViewMode currentMode;
  final int? selectedCategoryId;
  final int? selectedPackId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logic = ref.read(installerPageLogicProvider.notifier);
    final categoriesAsync = ref.watch(categoriesLogicSharedProvider);
    final packsAsync = ref.watch(packsLogicSharedProvider);

    return Container(
      width: 210,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Todos ────────────────────────────────────────────────────────
            _SidebarItem(
              icon: Icons.apps,
              label: 'Todos',
              selected: currentMode == InstallerViewMode.all,
              onTap: logic.selectAll,
            ),
            const SizedBox(height: 8),

            // ── Software independiente ────────────────────────────────────
            _SidebarSection(label: 'Software independiente'),
            categoriesAsync.when(
              data: (state) {
                final categories = state.categoriesList;
                if (categories.isEmpty) {
                  return _SidebarEmptyHint(text: 'Sin categorías');
                }
                return Column(
                  children: categories
                      .map(
                        (c) => _SidebarItem(
                          icon: _categoryIcon(c.icon),
                          label: c.name,
                          selected: currentMode == InstallerViewMode.category &&
                              selectedCategoryId == c.id,
                          onTap: () => logic.selectCategory(c.id),
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const _SidebarLoadingIndicator(),
              error: (e, _) => _SidebarEmptyHint(text: 'Error al cargar'),
            ),
            const SizedBox(height: 8),

            // ── Paquetes ─────────────────────────────────────────────────
            _SidebarSection(label: 'Paquetes'),
            packsAsync.when(
              data: (state) {
                final packs = state.packsList;
                if (packs.isEmpty) {
                  return _SidebarEmptyHint(text: 'Sin paquetes');
                }
                return Column(
                  children: packs
                      .map(
                        (p) => _SidebarItem(
                          icon: _packIcon(p.icon),
                          label: p.name,
                          selected: currentMode == InstallerViewMode.pack &&
                              selectedPackId == p.id,
                          onTap: () => logic.selectPack(p.id),
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const _SidebarLoadingIndicator(),
              error: (e, _) => _SidebarEmptyHint(text: 'Error al cargar'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(String? iconName) {
    return switch (iconName) {
      'code' => Icons.code,
      'design' => Icons.brush,
      'audio' => Icons.headphones,
      'video' => Icons.videocam,
      'security' => Icons.security,
      'browser' => Icons.public,
      'office' => Icons.business_center,
      'game' => Icons.videogame_asset,
      'utils' => Icons.build,
      _ => Icons.folder_outlined,
    };
  }

  IconData _packIcon(String? iconName) {
    return switch (iconName) {
      'web' => Icons.language,
      'dev' => Icons.developer_mode,
      'design' => Icons.palette,
      'office' => Icons.business,
      _ => Icons.inventory_2_outlined,
    };
  }
}

// ─── Private sub-widgets ─────────────────────────────────────────────────────

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return selected
        ? Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            color: Colors.white.withValues(alpha: 0.1),
            elevation: 0,
            child: ListTile(
              dense: true,
              leading: Icon(icon, color: Colors.white, size: 20),
              title: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: onTap,
            ),
          )
        : ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(icon, color: Colors.white60, size: 20),
            title: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: onTap,
          );
  }
}

class _SidebarSection extends StatelessWidget {
  const _SidebarSection({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white38,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SidebarLoadingIndicator extends StatelessWidget {
  const _SidebarLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _SidebarEmptyHint extends StatelessWidget {
  const _SidebarEmptyHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white30,
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }
}
