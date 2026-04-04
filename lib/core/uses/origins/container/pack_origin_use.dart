import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [InstallationPacksTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [InstallationPacksTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class PackDriftOriginUse {
  /// Primary key.
  final int id;

  /// Pack name (unique).
  final String name;

  /// Optional description.
  final String? description;

  /// Whether the pack is active.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const PackDriftOriginUse({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds origin from Drift [InstallationPacksTableData] (same shape as DB row).
  /// Construye el origen desde [InstallationPacksTableData] de Drift (misma forma que la fila).
  factory PackDriftOriginUse.fromTableData(InstallationPacksTableData row) {
    return PackDriftOriginUse(
      id: row.id,
      name: row.name,
      description: row.description,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
