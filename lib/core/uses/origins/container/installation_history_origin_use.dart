import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [InstallationHistoryTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [InstallationHistoryTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class InstallationHistoryDriftOriginUse {
  /// Primary key.
  final int id;

  /// Foreign key to installations (nullable if installation record was deleted).
  final int? installationId;

  /// Foreign key to software.
  final int? softwareId;

  /// Software name at time of installation (denormalized for history).
  final String softwareName;

  /// When the installation occurred.
  final DateTime installationDate;

  /// Final status: success, failed, or cancelled.
  final HistoryStatusEnumDatabase status;

  /// Duration in seconds (nullable).
  final int? durationSeconds;

  /// Error details if failed.
  final String? errorDetails;

  /// Creation timestamp.
  final DateTime createdAt;

  const InstallationHistoryDriftOriginUse({
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

  /// Builds origin from Drift [InstallationHistoryTableData] (same shape as DB row).
  /// Construye el origen desde [InstallationHistoryTableData] de Drift (misma forma que la fila).
  factory InstallationHistoryDriftOriginUse.fromTableData(
    InstallationHistoryTableData row,
  ) {
    return InstallationHistoryDriftOriginUse(
      id: row.id,
      installationId: row.installationId,
      softwareId: row.softwareId,
      softwareName: row.softwareName,
      installationDate: row.installationDate,
      status: row.status,
      durationSeconds: row.durationSeconds,
      errorDetails: row.errorDetails,
      createdAt: row.createdAt,
    );
  }
}
