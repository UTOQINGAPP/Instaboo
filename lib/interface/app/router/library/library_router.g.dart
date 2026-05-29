// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$libraryShellRoute];

RouteBase get $libraryShellRoute => ShellRouteData.$route(
  navigatorKey: LibraryShellRoute.$navigatorKey,
  factory: $LibraryShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/library/home',
      factory: $HomePageLibraryRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/library/settings',
      factory: $SettingsPageLibraryRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/library/packages',
      factory: $PackagesPageLibraryRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/library/history',
      factory: $HistoryPageLibraryRoute._fromState,
    ),
  ],
);

extension $LibraryShellRouteExtension on LibraryShellRoute {
  static LibraryShellRoute _fromState(GoRouterState state) =>
      const LibraryShellRoute();
}

mixin $HomePageLibraryRoute on GoRouteData {
  static HomePageLibraryRoute _fromState(GoRouterState state) =>
      const HomePageLibraryRoute();

  @override
  String get location => GoRouteData.$location('/library/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsPageLibraryRoute on GoRouteData {
  static SettingsPageLibraryRoute _fromState(GoRouterState state) =>
      const SettingsPageLibraryRoute();

  @override
  String get location => GoRouteData.$location('/library/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PackagesPageLibraryRoute on GoRouteData {
  static PackagesPageLibraryRoute _fromState(GoRouterState state) =>
      const PackagesPageLibraryRoute();

  @override
  String get location => GoRouteData.$location('/library/packages');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HistoryPageLibraryRoute on GoRouteData {
  static HistoryPageLibraryRoute _fromState(GoRouterState state) =>
      const HistoryPageLibraryRoute();

  @override
  String get location => GoRouteData.$location('/library/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
