import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [InstallationsTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [InstallationsTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class InstallationDriftOriginUse {
  /// Primary key.
  final int id;

  /// Source type: software or pack.
  final InstallationSourceTypeEnumDatabase sourceType;

  /// Foreign key to software (when source_type = 'software').
  final int? softwareId;

  /// Foreign key to pack (when source_type = 'pack').
  final int? packId;

  /// Display name for the installation.
  final String displayName;

  /// Installation status.
  final InstallationStatusEnumDatabase status;

  /// Progress percentage (0-100).
  final int progress;

  /// Position in the installation queue.
  final int? queuePosition;

  /// When installation started.
  final DateTime? startedAt;

  /// When installation completed.
  final DateTime? completedAt;

  /// Error message if failed.
  final String? errorMessage;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const InstallationDriftOriginUse({
    required this.id,
    required this.sourceType,
    this.softwareId,
    this.packId,
    required this.displayName,
    required this.status,
    required this.progress,
    this.queuePosition,
    this.startedAt,
    this.completedAt,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds origin from Drift [InstallationsTableData] (same shape as DB row).
  /// Construye el origen desde [InstallationsTableData] de Drift (misma forma que la fila).
  factory InstallationDriftOriginUse.fromTableData(
    InstallationsTableData row,
  ) {
    return InstallationDriftOriginUse(
      id: row.id,
      sourceType: row.sourceType,
      softwareId: row.softwareId,
      packId: row.packId,
      displayName: row.displayName,
      status: row.status,
      progress: row.progress,
      queuePosition: row.queuePosition,
      startedAt: row.startedAt,
      completedAt: row.completedAt,
      errorMessage: row.errorMessage,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
