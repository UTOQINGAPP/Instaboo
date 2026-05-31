import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for category resolution and persistence.
/// Contrato para resolución y persistencia de categorías.
abstract class CategoriesServiceRule {
  /// Creates a new category.
  /// Crea una nueva categoría.
  Future<ResponseRule<CategoryDataRule>> create(
    String name,
    {String? description, String? icon, int? parentId}
  );
  
  /// Returns a category by id.
  /// Devuelve una categoría por id.
  Future<ResponseRule<CategoryDataRule>> getById(int id);
  
  /// Returns all categories.
  /// Devuelve todas las categorías.
  Future<ResponseRule<List<CategoryDataRule>>> getAll({bool? rootOnly});
  
  /// Returns the children of a category.
  /// Devuelve los hijos de una categoría.
  Future<ResponseRule<List<CategoryDataRule>>> getChildren(int parentId);
  
  /// Updates a category.
  /// Actualiza una categoría.
  Future<ResponseRule<CategoryDataRule>> update(
    int id,
    {String? name, String? description, String? icon}
  );
  
  /// Deletes a category.
  /// Elimina una categoría.
  Future<ResponseRule<Unit>> delete(int id);

  /// Returns the hierarchy of categories.
  /// Devuelve la jerarquía de categorías.
  Future<ResponseRule<List<CategoryDataRule>>> getHierarchy();
  
  /// Reorders a category.
  /// Reordena una categoría.
  Future<ResponseRule<Unit>> reorder(int categoryId, int newSortOrder);
  
}