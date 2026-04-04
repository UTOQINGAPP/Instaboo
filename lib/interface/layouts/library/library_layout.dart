import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/interface/app/router/library/library_router.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/layouts/library/components/components_library.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

export 'pages/pages_library.dart';

class LibraryLayout extends StatefulWidget {
  final Widget child;
  const LibraryLayout({super.key, required this.child});

  @override
  State<LibraryLayout> createState() => _LibraryLayoutState();
}

class _LibraryLayoutState extends State<LibraryLayout> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: context.width(100),
        height: context.height(100),
        child: Row(
          children: [
            _SideMenuView(),
            VerticalDivider(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
              thickness: 1,
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}

class _SideMenuView extends StatefulWidget {
  const _SideMenuView();

  @override
  State<_SideMenuView> createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<_SideMenuView> {
  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.uri.path;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SizedBox(
      width: 250,
      height: double.infinity,

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset(
              AssetsConfig.logo,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            Text(
              'Instaboo',
              style: textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
            SizedBox(height: 10),
            ItemSideMenuComponentLibrary(
              icon: Icons.library_books,
              title: 'Biblioteca Software',
              onTap: () {
                HomePageLibraryRoute().go(context);
              },
              selected: location == HomePageLibraryRoute().location,
            ),
            SizedBox(height: 10),
            ItemSideMenuComponentLibrary(
              icon: Icons.group,
              title: 'Gestionar Paquetes',
              onTap: () {
                PackagesPageLibraryRoute().go(context);
              },
              selected: location == PackagesPageLibraryRoute().location,
            ),
            SizedBox(height: 10),
            ItemSideMenuComponentLibrary(
              icon: Icons.settings,
              title: 'Configuración',
              onTap: () {
                SettingsPageLibraryRoute().go(context);
              },
              selected: location == SettingsPageLibraryRoute().location,
            ),
            Spacer(),
            CustomElevatedButtonComponentShared.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.black.withValues(alpha: .2),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () {
                HomeRoute().go(context);
              },
              icon: Icon(Icons.logout),
              label: Text('Regresar al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
