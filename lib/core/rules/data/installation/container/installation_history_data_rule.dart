import 'package:instaboo/core/rules/enums/enums_rule.dart';

/// Installation history data entity for reports and auditing.
/// Entidad de datos de historial de instalación para reportes y auditoría.
///
/// Maps to: installation_history table
/// Mapea a: tabla installation_history
class InstallationHistoryDataRule {
  /// Primary key.
  final int id;

  /// Foreign key to installations (nullable if record was deleted).
  final int? installationId;

  /// Foreign key to software.
  final int? softwareId;

  /// Software name at time of installation (denormalized).
  final String softwareName;

  /// When the installation occurred.
  final DateTime installationDate;

  /// Final status: success, failed, or cancelled.
  final HistoryStatusEnumRule status;

  /// Duration in seconds (nullable).
  final int? durationSeconds;

  /// Error details if failed.
  final String? errorDetails;

  /// Creation timestamp.
  final DateTime createdAt;

  const InstallationHistoryDataRule({
    required this.id,
    this.installationId,
    this.softwareId,
    required this.softwareName,
    required this.installationDate,
    required this.status,
    this.durationSeconds,
    this.errorDetails,
    required this.createdAt,
  });

  InstallationHistoryDataRule copyWith({
    int? id,
    int? installationId,
    int? softwareId,
    String? softwareName,
    DateTime? installationDate,
    HistoryStatusEnumRule? status,
    int? durationSeconds,
    String? errorDetails,
    DateTime? createdAt,
  }) => InstallationHistoryDataRule(
    id: id ?? this.id,
    installationId: installationId ?? this.installationId,
    softwareId: softwareId ?? this.softwareId,
    softwareName: softwareName ?? this.softwareName,
    installationDate: installationDate ?? this.installationDate,
    status: status ?? this.status,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    errorDetails: errorDetails ?? this.errorDetails,
    createdAt: createdAt ?? this.createdAt,
  );
}
