import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instaboo/ui/ui.dart';

GoRouter routerConfig = GoRouter(
  initialLocation: SelectedPageHome.link,
  
  routes:_routes);

final List<RouteBase> _routes=[
_homeRoutes,
GoRoute(
        path: AddPackagePage.link,
        name: AddPackagePage.name,
        builder: (context, state) => const AddPackagePage(),
      ),
];


final RouteBase _homeRoutes = StatefulShellRoute.indexedStack(
  
  pageBuilder: (context, state, navigationShell) {
    return MaterialPage(
        child: HomeLayout(navigationShell: navigationShell));
  },
  branches: [

    StatefulShellBranch(routes: [
      GoRoute(
        path: PackagesPageHome.link,
        name: PackagesPageHome.name,
        builder: (context, state) => const PackagesPageHome(),
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