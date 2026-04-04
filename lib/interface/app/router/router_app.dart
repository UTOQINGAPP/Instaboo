import 'package:go_router/go_router.dart';
import 'package:instaboo/interface/app/router/library/library_router.dart' show libraryRouter;
import 'package:instaboo/interface/app/router/pages/pages_router.dart' show HomeRoute, pagesRouter;



/// Centralized app router that composes auth and dashboard routers.
/// Router de la aplicación que centraliza auth y dashboard.
final GoRouter appRouter = GoRouter(
  initialLocation:  HomeRoute().location,

  routes: <RouteBase>[ ...pagesRouter,...libraryRouter],
  debugLogDiagnostics: true,

);