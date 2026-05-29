import 'package:instaboo/core/infra/infra_core.dart';

/// Raw installation pack row from Drift.
/// Fila de pack de instalación cruda desde Drift.
class PackOriginUse {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PackOriginUse({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory PackOriginUse.fromDrift(InstallationPacksTableData row) =>
      PackOriginUse(
        id: row.id,
        name: row.name,
        description: row.description,
        icon: row.icon,
        isActive: row.isActive,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
