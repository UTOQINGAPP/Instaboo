import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Categories consumer implementation. Delegates to [CategoriesServiceRule].
/// Implementación del consumer de categorías. Delega a [CategoriesServiceRule].
class CategoriesConsumerRule {
  final CategoriesServiceRule _service;

  CategoriesConsumerRule({required CategoriesServiceRule service})
    : _service = service;

  @override
  Future<ApiResponseRule<Unit>> createCategory({
    required String name,
    String? description,
    String? icon,
  }) {
    return _service.createCategory(
      name: name,
      description: description,
      icon: icon,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> updateCategory({
    required int categoryId,
    String? name,
    String? description,
    String? icon,
  }) {
    return _service.updateCategory(
      categoryId: categoryId,
      name: name,
      description: description,
      icon: icon,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> deleteCategory(int categoryId) {
    return _service.deleteCategory(categoryId);
  }

  @override
  Future<ApiResponseRule<CategoriesDataRule>> getCategoryById(int categoryId) {
    return _service.getCategoryById(categoryId);
  }

  @override
  Future<ApiResponseRule<List<CategoriesDataRule>>> listCategories() {
    return _service.listCategories();
  }
}
