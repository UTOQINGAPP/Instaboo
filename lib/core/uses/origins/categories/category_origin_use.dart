import 'package:instaboo/core/infra/infra_core.dart';

/// Raw category row from Drift.
/// Fila de categoría cruda desde Drift.
class CategoryOriginUse {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final int sortOrder;
  final int? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryOriginUse({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.sortOrder,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory CategoryOriginUse.fromDrift(CategoriesTableData row) =>
      CategoryOriginUse(
        id: row.id,
        name: row.name,
        description: row.description,
        icon: row.icon,
        sortOrder: row.sortOrder,
        parentId: row.parentId,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
