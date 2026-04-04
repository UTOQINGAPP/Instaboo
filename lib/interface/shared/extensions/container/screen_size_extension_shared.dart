import 'package:flutter/material.dart';

/// Extensión para cálculos de dimensiones de pantalla basados en porcentajes.
/// Extension for screen dimension calculations based on percentages.
extension ScreenSizeExtensionShared on BuildContext {
  /// Retorna un ancho dinámico basado en un porcentaje del 0-100% del ancho de pantalla.
  /// Returns a dynamic width based on a percentage from 0-100% of screen width.
  ///
  /// [percentage] debe estar entre 0.0 y 100.0 (inclusive).
  /// [percentage] must be between 0.0 and 100.0 (inclusive).
  ///
  /// Lanza [ArgumentError] si el porcentaje está fuera del rango válido.
  /// Throws [ArgumentError] if percentage is outside valid range.
  double width(double percentage) {
    _validatePercentage(percentage);
    final screenWidth = MediaQuery.of(this).size.width;
    _validateScreenDimension(screenWidth, 'width');
    return screenWidth * (percentage / 100);
  }

  /// Retorna un alto dinámico basado en un porcentaje del 0-100% del alto de pantalla.
  /// Returns a dynamic height based on a percentage from 0-100% of screen height.
  ///
  /// [percentage] debe estar entre 0.0 y 100.0 (inclusive).
  /// [percentage] must be between 0.0 and 100.0 (inclusive).
  ///
  /// Lanza [ArgumentError] si el porcentaje está fuera del rango válido.
  /// Throws [ArgumentError] if percentage is outside valid range.
  double height(double percentage) {
    _validatePercentage(percentage);
    final screenHeight = MediaQuery.of(this).size.height;
    _validateScreenDimension(screenHeight, 'height');
    return screenHeight * (percentage / 100);
  }

  /// Valida que el porcentaje esté en el rango válido.
  /// Validates that percentage is within valid range.
  void _validatePercentage(double percentage) {
    if (percentage < 0.0 || percentage > 100.0) {
      throw ArgumentError(
        'Percentage must be between 0.0 and 100.0 (inclusive), got: $percentage',
        'percentage',
      );
    }
  }

  /// Valida que la dimensión de pantalla sea válida.
  /// Validates that screen dimension is valid.
  void _validateScreenDimension(double dimension, String dimensionName) {
    if (dimension <= 0.0 || !dimension.isFinite) {
      throw StateError(
        'Screen $dimensionName is invalid or zero: $dimension. '
        'Cannot calculate percentage-based dimension.',
      );
    }
  }
}