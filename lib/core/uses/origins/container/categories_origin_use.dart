import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [CategoriesTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [CategoriesTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class CategoriesDriftOriginUse {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoriesDriftOriginUse({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds origin from Drift [CategoriesTableData] (same shape as DB row).
  /// Construye el origen desde [CategoriesTableData] de Drift (misma forma que la fila).
  factory CategoriesDriftOriginUse.fromTableData(CategoriesTableData row) {
    return CategoriesDriftOriginUse(
      id: row.id,
      name: row.name,
      description: row.description,
      icon: row.icon,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
