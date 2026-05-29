import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';


/// Categories consumer implementation. Delegates to [CategoriesServiceRule].
/// Implementación del consumer de categorías. Delega a [CategoriesServiceRule].
class CategoriesConsumerRule {
  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final CategoriesServiceRule _service;

  /// Constructor.
  /// Constructor.
  CategoriesConsumerRule({required CategoriesServiceRule service})
    : _service = service;

  /// Creates a new category.
  /// Crea una nueva categoría.
  Future<ResponseRule<CategoryDataRule>> create(String name, {String? description, String? icon, int? parentId}) {
    return _service.create(name, description: description, icon: icon, parentId: parentId);
  }

  /// Deletes a category.
  /// Elimina una categoría.
  Future<ResponseRule<Unit>> delete(int id) {
    return _service.delete(id);
  }

  /// Returns all categories.
  /// Devuelve todas las categorías.
  Future<ResponseRule<List<CategoryDataRule>>> getAll({bool? rootOnly}) {
    return _service.getAll(rootOnly: rootOnly);
  }

  /// Returns a category by id.
  /// Devuelve una categoría por id.
  Future<ResponseRule<CategoryDataRule>> getById(int id) {
    return _service.getById(id);
  }

  /// Returns the children of a category.
  /// Devuelve los hijos de una categoría.
  Future<ResponseRule<List<CategoryDataRule>>> getChildren(int parentId) {
    return _service.getChildren(parentId);
  }

  /// Returns the hierarchy of categories.
  /// Devuelve la jerarquía de categorías.
  Future<ResponseRule<List<CategoryDataRule>>> getHierarchy() {
    return _service.getHierarchy();
  }

  /// Returns the software in a category.
  /// Devuelve el software en una categoría.
  Future<ResponseRule<List<SoftwareDataRule>>> getSoftwareInCategory(int categoryId) {
    return _service.getSoftwareInCategory(categoryId);
  }

  /// Reorders a category.
  /// Reordena una categoría.
  Future<ResponseRule<Unit>> reorder(int categoryId, int newSortOrder) {
    return _service.reorder(categoryId, newSortOrder);
  }

  /// Updates a category.
  /// Actualiza una categoría.
  Future<ResponseRule<CategoryDataRule>> update(int id, {String? name, String? description, String? icon}) {
    return _service.update(id, name: name, description: description, icon: icon);
  }
 

}