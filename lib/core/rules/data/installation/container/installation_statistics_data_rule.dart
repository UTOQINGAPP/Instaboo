/// Calculated installation statistics (not mapped to a single table).
/// Estadísticas de instalación calculadas (no mapeadas a una tabla).
///
/// Built from aggregation of installation_history and related data.
/// Construido a partir de agregación de installation_history y datos relacionados.
class InstallationStatisticsDataRule {
  /// Total number of installation history records.
  /// Número total de registros en el historial de instalaciones.
  final int totalCount;

  /// Number of successful installations.
  /// Número de instalaciones exitosas.
  final int successCount;

  /// Number of failed installations.
  /// Número de instalaciones fallidas.
  final int failedCount;

  /// Number of cancelled installations.
  /// Número de instalaciones canceladas.
  final int cancelledCount;

  /// Average duration in seconds (nullable if no data).
  /// Duración promedio en segundos (nullable si no hay datos).
  final double? averageDurationSeconds;

  /// Date of the most recent installation (nullable if none).
  /// Fecha de la instalación más reciente (nullable si no hay ninguna).
  final DateTime? lastInstallationDate;

  const InstallationStatisticsDataRule({
    required this.totalCount,
    required this.successCount,
    required this.failedCount,
    required this.cancelledCount,
    this.averageDurationSeconds,
    this.lastInstallationDate,
  });

  InstallationStatisticsDataRule copyWith({
    int? totalCount,
    int? successCount,
    int? failedCount,
    int? cancelledCount,
    double? averageDurationSeconds,
    DateTime? lastInstallationDate,
  }) =>
      InstallationStatisticsDataRule(
        totalCount: totalCount ?? this.totalCount,
        successCount: successCount ?? this.successCount,
        failedCount: failedCount ?? this.failedCount,
        cancelledCount: cancelledCount ?? this.cancelledCount,
        averageDurationSeconds:
            averageDurationSeconds ?? this.averageDurationSeconds,
        lastInstallationDate:
            lastInstallationDate ?? this.lastInstallationDate,
      );
}
