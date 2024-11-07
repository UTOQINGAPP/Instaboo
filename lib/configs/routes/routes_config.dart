import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:instaboo/ui/ui.dart';

GoRouter routerConfig =
    GoRouter(initialLocation: SelectedPageHome.link, routes: _routes);

final List<RouteBase> _routes = [
  _homeRoutes,
  GoRoute(
    path: EditPackagePage.link,
    name: EditPackagePage.name,
    pageBuilder: (context, state) {
      return FluentPage(
          child: EditPackagePage(
        title: 'Agregar paquete',
      ));
    },
  ),
];

final RouteBase _homeRoutes = StatefulShellRoute.indexedStack(
  pageBuilder: (context, state, navigationShell) {
    return MaterialPage(child: HomeLayout(navigationShell: navigationShell));
  },
  branches: [
    StatefulShellBranch(routes: [
      GoRoute(
        path: PackagesPageHome.link,
        name: PackagesPageHome.name,
        builder: (context, state) =>
            PackagesPageHome(idCategory: state.extra as int),
      ),
    ]),
    StatefulShellBranch(routes: [
      GoRoute(
        path: SelectedPageHome.link,
        name: SelectedPageHome.name,
        builder: (context, state) => const SelectedPageHome(),
      ),
    ]),
  ],
);
