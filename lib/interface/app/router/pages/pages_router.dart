import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instaboo/interface/pages/pages_interface.dart';

part 'pages_router.g.dart';

List<RouteBase> get pagesRouter => $appRoutes;


@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData with $HomeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

@TypedGoRoute<InstallerRoute>(path: '/installer')
class InstallerRoute extends GoRouteData with $InstallerRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InstallerPage();
  }
}

@TypedGoRoute<InstallingRoute>(path: '/installing')
class InstallingRoute extends GoRouteData with $InstallingRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InstallingPage();
  }
}

@TypedGoRoute<ResultsRoute>(path: '/results')
class ResultsRoute extends GoRouteData with $ResultsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResultsPage();
  }
}