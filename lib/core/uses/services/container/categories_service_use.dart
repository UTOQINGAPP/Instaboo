import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Categories service implementation. CRUD and list via Drift.
/// For use by consumers/UI only. Other services must NOT use this; they use [CategoryResolutionUse.resolveById] instead (CMI: no service inside service).
///
/// Implementación del servicio de categorías. CRUD y listado vía Drift.
/// Solo para uso por consumers/UI. Otros servicios NO deben usarlo; usan [CategoryResolutionUse.resolveById] (CMI: no servicio dentro de servicio).
class CategoriesServiceUse implements CategoriesServiceRule {
  final DatabaseInfra _db = DatabaseInfra.instance;

  CategoriesServiceUse();

  @override
  Future<ApiResponseRule<Unit>> createCategory({
    required String name,
    String? description,
    String? icon,
  }) async {
    try {
      await _db.into(_db.categoriesTable).insert(
            CategoriesTableCompanion.insert(
              name: name,
              description: Value(description),
              icon: Value(icon),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CREATE_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updateCategory({
    required int categoryId,
    String? name,
    String? description,
    String? icon,
  }) async {
    try {
      await (_db.update(_db.categoriesTable)
            ..where((t) => t.id.equals(categoryId)))
          .write(
        CategoriesTableCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          description: description != null
              ? Value(description)
              : const Value.absent(),
          icon: icon != null ? Value(icon) : const Value.absent(),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deleteCategory(int categoryId) async {
    try {
      await (_db.delete(_db.categoriesTable)
            ..where((t) => t.id.equals(categoryId)))
          .go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<CategoriesDataRule>> getCategoryById(
    int categoryId,
  ) async {
    try {
      final rows = await (_db.select(_db.categoriesTable)
            ..where((t) => t.id.equals(categoryId))
            ..limit(1))
          .get();
      if (rows.isEmpty) {
        return const FailureResponseRule(
          message: 'Category not found',
          errorCode: 'CATEGORY_NOT_FOUND',
        );
      }
      final data = CategoriesAdapterUse.fromOrigin(
        CategoriesDriftOriginUse.fromTableData(rows.single),
      );
      return SuccessResponseRule<CategoriesDataRule>(data: data);
    } catch (e) {
      return FailureResponseRule<CategoriesDataRule>(
        message: e.toString(),
        errorCode: 'GET_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<CategoriesDataRule>>> listCategories() async {
    try {
      final rows = await (_db.select(_db.categoriesTable)
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .get();
      final list = rows
          .map(
            (row) => CategoriesAdapterUse.fromOrigin(
              CategoriesDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule<List<CategoriesDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<CategoriesDataRule>>(
        message: e.toString(),
        errorCode: 'LIST_CATEGORIES',
      );
    }
  }
}
