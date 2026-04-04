import 'package:flutter/material.dart';
import 'package:instaboo/interface/app/router/router_app.dart';
import 'package:go_transitions/go_transitions.dart';

class AppInterface extends StatelessWidget {
  const AppInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Instaboo',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.windows: GoTransitions.fade},
        ),
      ),
    );
  }
}
