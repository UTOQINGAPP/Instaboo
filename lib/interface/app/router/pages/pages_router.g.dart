// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
  $installerRoute,
  $installingRoute,
  $resultsRoute,
];

RouteBase get $homeRoute =>
    GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

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

RouteBase get $installerRoute =>
    GoRouteData.$route(path: '/installer', factory: $InstallerRoute._fromState);

mixin $InstallerRoute on GoRouteData {
  static InstallerRoute _fromState(GoRouterState state) => InstallerRoute();

  @override
  String get location => GoRouteData.$location('/installer');

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

RouteBase get $installingRoute => GoRouteData.$route(
  path: '/installing',
  factory: $InstallingRoute._fromState,
);

mixin $InstallingRoute on GoRouteData {
  static InstallingRoute _fromState(GoRouterState state) => InstallingRoute();

  @override
  String get location => GoRouteData.$location('/installing');

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

RouteBase get $resultsRoute =>
    GoRouteData.$route(path: '/results', factory: $ResultsRoute._fromState);

mixin $ResultsRoute on GoRouteData {
  static ResultsRoute _fromState(GoRouterState state) => ResultsRoute();

  @override
  String get location => GoRouteData.$location('/results');

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
