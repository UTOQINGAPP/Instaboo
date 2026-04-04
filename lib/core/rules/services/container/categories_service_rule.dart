import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

/// Contract for category resolution and persistence.
/// Contrato para resolución y persistencia de categorías.
abstract class CategoriesServiceRule {
  /// Creates a new category.
  /// Crea una nueva categoría.
  Future<ApiResponseRule<Unit>> createCategory({
    required String name,
    String? description,
    String? icon,
  });

  /// Updates an existing category.
  /// Actualiza una categoría existente.
  Future<ApiResponseRule<Unit>> updateCategory({
    required int categoryId,
    String? name,
    String? description,
    String? icon,
  });

  /// Removes a category from the catalog.
  /// Elimina una categoría del catálogo.
  Future<ApiResponseRule<Unit>> deleteCategory(int categoryId);

  /// Returns a category by id, or failure if not found.
  /// Devuelve una categoría por id, o fallo si no existe.
  Future<ApiResponseRule<CategoriesDataRule>> getCategoryById(int categoryId);

  /// Lists all categories.
  /// Lista todas las categorías.
  Future<ApiResponseRule<List<CategoriesDataRule>>> listCategories();
}
