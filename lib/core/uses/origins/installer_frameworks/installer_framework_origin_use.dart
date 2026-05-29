import 'package:instaboo/core/infra/infra_core.dart';

/// Raw installer framework row from Drift.
/// Fila cruda de framework de instalador desde Drift.
class InstallerFrameworkOriginUse {
  final int id;
  final String name;
  final String? description;
  final String silentArgs;
  final bool isBuiltIn;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InstallerFrameworkOriginUse({
    required this.id,
    required this.name,
    this.description,
    required this.silentArgs,
    required this.isBuiltIn,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory InstallerFrameworkOriginUse.fromDrift(
    InstallerFrameworksTableData row,
  ) =>
      InstallerFrameworkOriginUse(
        id: row.id,
        name: row.name,
        description: row.description,
        silentArgs: row.silentArgs,
        isBuiltIn: row.isBuiltIn,
        sortOrder: row.sortOrder,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
