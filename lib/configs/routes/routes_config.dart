import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:instaboo/configs/routes/transporters/transporters_routes.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/ui.dart';
export 'transporters/transporters_routes.dart';

// Configuration for GoRouter with initial location set to the Home Page link
GoRouter routerConfig =
    GoRouter(initialLocation: SelectedPageHome.link, routes: _routes);

// List of all routes in the application
final List<RouteBase> _routes = [
  _homeRoutes,
  GoRoute(
    path: EditPackagePage.link,
    name: EditPackagePage.name,
    pageBuilder: (context, state) {
      final extra = state.extra;
      if (extra != null) {
        final GeneralPageTransporter<PackageData> transporter =
            (extra as GeneralPageTransporter<PackageData>);
        return FluentPage(
            child: EditPackagePage(
          title: transporter.title,
          package: transporter.data,
        ));
      }
      return FluentPage(
          child: EditPackagePage(
        title: 'Agregar paquete',
      ));
    },
  ),
  GoRoute(
    path: InstallPage.link,
    name: InstallPage.name,
    pageBuilder: (context, state) {
      return FluentPage(
          child: InstallPage(
        transporter: (state.extra as InstallPageTransporter),
      ));
    },
  ),
];

// Defines the home routes using a StatefulShellRoute with an indexed stack
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
