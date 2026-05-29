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
      theme: _buildDarkTheme(),
    );
  }
}

/// Builds the global dark theme coherent with the acrylic background (0xCC222222).
/// Construye el tema oscuro global coherente con el fondo acrílico (0xCC222222).
ThemeData _buildDarkTheme() {
  const Color primary = Color(0xFF6C8EFF);
  const Color white = Colors.white;
  const Color surfaceTransparent = Color(0x1AFFFFFF); // white 10%
  const Color dividerColor = Color(0x33FFFFFF);       // white 20%
  const Color hintColor = Color(0x99FFFFFF);          // white 60%
  const Color dialogBackground = Color(0xFF2D2D2D);

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: white,
      surface: surfaceTransparent,
      onSurface: white,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.windows: GoTransitions.fade},
    ),
    // Cards semitransparentes para dejar ver el efecto acrílico.
    cardTheme: CardThemeData(
      color: surfaceTransparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(color: white),
      subtitleTextStyle: TextStyle(color: white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0x80FFFFFF), // white 50%
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: white),
    ),
    dividerTheme: const DividerThemeData(color: dividerColor),
    dialogTheme: DialogThemeData(
      backgroundColor: dialogBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: const TextStyle(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(color: white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: white),
      hintStyle: const TextStyle(color: hintColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary),
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: white),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(white),
      side: const BorderSide(color: white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return primary;
        return const Color(0xFF9E9E9E);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary.withValues(alpha: 0.4);
        }
        return dividerColor;
      }),
    ),
  );
}
