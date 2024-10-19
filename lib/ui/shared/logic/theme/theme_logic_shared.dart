import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

part 'theme_logic_shared.g.dart';

// Enumeración para los indicadores de navegación
enum NavigationIndicators { sticky, end }

class ThemeState {
  final AccentColor color;
  final ThemeMode mode;
  final PaneDisplayMode displayMode;
  final NavigationIndicators indicator;
  final WindowEffect windowEffect;
  final TextDirection textDirection;
  final Locale? locale;

  ThemeState({
    required this.color,
    required this.mode,
    required this.displayMode,
    required this.indicator,
    required this.windowEffect,
    required this.textDirection,
    this.locale,
  });

  // Método copyWith para poder actualizar el estado fácilmente
  ThemeState copyWith({
    AccentColor? color,
    ThemeMode? mode,
    PaneDisplayMode? displayMode,
    NavigationIndicators? indicator,
    WindowEffect? windowEffect,
    TextDirection? textDirection,
    Locale? locale,
  }) {
    return ThemeState(
      color: color ?? this.color,
      mode: mode ?? this.mode,
      displayMode: displayMode ?? this.displayMode,
      indicator: indicator ?? this.indicator,
      windowEffect: windowEffect ?? this.windowEffect,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
    );
  }
}

@Riverpod(keepAlive: true)
class ThemeLogicShared extends _$ThemeLogicShared {
  @override
  ThemeState build() {
    // Estado inicial con valores predeterminados
    return ThemeState(
      color: systemAccentColor,
      mode: ThemeMode.light,
      displayMode: PaneDisplayMode.auto,
      indicator: NavigationIndicators.sticky,
      windowEffect: WindowEffect.disabled,
      textDirection: TextDirection.ltr,
    );
  }

  // Métodos para actualizar el estado
  void updateColor(AccentColor newColor) {
    state = state.copyWith(color: newColor);
  }

  void updateMode(ThemeMode newMode) {
    state = state.copyWith(mode: newMode);
  }

  void updateDisplayMode(PaneDisplayMode newDisplayMode) {
    state = state.copyWith(displayMode: newDisplayMode);
  }

  void updateIndicator(NavigationIndicators newIndicator) {
    state = state.copyWith(indicator: newIndicator);
  }

  void updateWindowEffect(WindowEffect newWindowEffect) {
    state = state.copyWith(windowEffect: newWindowEffect);
  }

  void updateTextDirection(TextDirection newDirection) {
    state = state.copyWith(textDirection: newDirection);
  }

  void updateLocale(Locale? newLocale) {
    state = state.copyWith(locale: newLocale);
  }

  // Método para establecer el efecto de la ventana

  void setEffect(
      WindowEffect effect, Color micaBackgroundColor, bool isDarkMode) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: isDarkMode,
    );
    updateWindowEffect(effect);
  }
}

// Función para obtener el color de acento del sistema
AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
