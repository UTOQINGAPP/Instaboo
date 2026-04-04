/// Category data entity for software classification.
/// Entidad de datos de categoría para clasificación de software.
///
/// Maps to: categories table
/// Mapea a: tabla categories
class CategoriesDataRule {
  /// Primary key.
  final int id;

  /// Category name (unique).
  final String name;

  /// Optional description.
  final String? description;

  /// Icon identifier (e.g. emoji or icon name).
  final String? icon;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const CategoriesDataRule({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoriesDataRule copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoriesDataRule(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
