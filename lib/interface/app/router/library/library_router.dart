import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instaboo/interface/layouts/layouts_interface.dart';

part 'library_router.g.dart';

/// English: Navigator key for the library shell route.
/// Español: Clave de navegador para la ruta shell de la biblioteca.
final GlobalKey<NavigatorState> libraryShellNavigatorKey =
    GlobalKey<NavigatorState>();

/// English: List of route definitions for the library module.
/// Español: Lista de definiciones de rutas para el módulo de biblioteca.
List<RouteBase> get libraryRouter => $appRoutes;

/// English: Shell route that provides the persistent `LibraryLayout` with
/// the side menu for all `/library/*` pages.
/// Español: Ruta shell que proporciona el `LibraryLayout` persistente con
/// el menú lateral para todas las páginas `/library/*`.
@TypedShellRoute<LibraryShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomePageLibraryRoute>(path: '/library/home'),
    TypedGoRoute<SettingsPageLibraryRoute>(path: '/library/settings'),
    TypedGoRoute<PackagesPageLibraryRoute>(path: '/library/packages'),
  ],
)
class LibraryShellRoute extends ShellRouteData {
  /// English: Creates the library shell route.
  /// Español: Crea la ruta shell de biblioteca.
  const LibraryShellRoute();

  /// English: Navigator key used by the shell route.
  /// Español: Clave de navegador usada por la ruta shell.
  static final GlobalKey<NavigatorState> $navigatorKey =
      libraryShellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return LibraryLayout(child: navigator);
  }
}

/// English: Route definition for the library home page.
/// Español: Definición de ruta para la página de inicio de biblioteca.
class HomePageLibraryRoute extends GoRouteData with $HomePageLibraryRoute {
  /// English: Creates the library home page route.
  /// Español: Crea la ruta de página de inicio de biblioteca.
  const HomePageLibraryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePageLibrary();
  }
}

/// English: Route definition for the library settings page.
/// Español: Definición de ruta para la página de configuración de biblioteca.
class SettingsPageLibraryRoute extends GoRouteData
    with $SettingsPageLibraryRoute {
  /// English: Creates the library settings page route.
  /// Español: Crea la ruta de página de configuración de biblioteca.
  const SettingsPageLibraryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPageLibrary();
  }
}

/// English: Route definition for the library packages page.
/// Español: Definición de ruta para la página de paquetes de biblioteca.
class PackagesPageLibraryRoute extends GoRouteData
    with $PackagesPageLibraryRoute {
  /// English: Creates the library packages page route.
  /// Español: Crea la ruta de página de paquetes de biblioteca.
  const PackagesPageLibraryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PackagesPageLibrary();
  }
}