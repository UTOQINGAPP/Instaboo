import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeLogicShared = ref.watch(themeLogicSharedProvider);

    return FluentApp.router(
      title: appTitle,
      themeMode: themeLogicShared.mode,
      debugShowCheckedModeBanner: false,
      color: themeLogicShared.color,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: themeLogicShared.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        accentColor: themeLogicShared.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      locale: themeLogicShared.locale,
      builder: (context, child) {
        return Directionality(
          textDirection: themeLogicShared.textDirection,
          child: NavigationPaneTheme(
            data: NavigationPaneThemeData(
              backgroundColor: themeLogicShared.windowEffect !=
                      flutter_acrylic.WindowEffect.disabled
                  ? FluentTheme.of(context)
                      .micaBackgroundColor
                      .withOpacity(0.05) // Usar colores de Fluent
                  : null,
            ),
            child: child!,
          ),
        );
      },
      routeInformationParser: routerConfig.routeInformationParser,
      routerDelegate: routerConfig.routerDelegate,
      routeInformationProvider: routerConfig.routeInformationProvider,
    );
  }
}
