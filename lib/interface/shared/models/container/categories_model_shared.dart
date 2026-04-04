/// UI model for shared categories used across interface layer.
/// Modelo de UI para categorías compartidas usado en la capa interface.
class CategoriesModelShared {
  /// Primary key.
  /// Clave primaria.
  final int id;

  /// Category name (unique).
  /// Nombre de categoría (único).
  final String name;

  /// Optional description.
  /// Descripción opcional.
  final String? description;

  /// Icon identifier (e.g. emoji or icon name).
  /// Identificador de icono (por ejemplo emoji o nombre de icono).
  final String? icon;

  /// Creates a categories UI model.
  /// Crea un modelo de UI de categoría.
  const CategoriesModelShared({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}
