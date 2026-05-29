import 'package:instaboo/core/infra/infra_core.dart';

/// Raw installation history row from Drift.
/// Fila de historial de instalación cruda desde Drift.
class HistoryOriginUse {
  final int id;
  final int? softwareId;
  final int? packId;
  final String softwareName;
  final String? softwareVersion;
  final String? installerType;
  final String status;
  final String? errorDetails;
  final DateTime startedAt;
  final DateTime completedAt;
  final DateTime createdAt;

  /// JSON snapshot of the machine that ran this installation.
  /// Snapshot JSON del equipo que ejecutó esta instalación.
  final String? machineInfo;

  const HistoryOriginUse({
    required this.id,
    this.softwareId,
    this.packId,
    required this.softwareName,
    this.softwareVersion,
    this.installerType,
    required this.status,
    this.errorDetails,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
    this.machineInfo,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory HistoryOriginUse.fromDrift(InstallationHistoryTableData row) =>
      HistoryOriginUse(
        id: row.id,
        softwareId: row.softwareId,
        packId: row.packId,
        softwareName: row.softwareName,
        softwareVersion: row.softwareVersion,
        installerType: row.installerType,
        status: row.status,
        errorDetails: row.errorDetails,
        startedAt: row.startedAt,
        completedAt: row.completedAt,
        createdAt: row.createdAt,
        machineInfo: row.machineInfo,
      );
}
