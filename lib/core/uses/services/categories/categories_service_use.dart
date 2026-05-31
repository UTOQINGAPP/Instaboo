import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Category persistence in SQLite; uses origin/adapter for category and software data rules.
/// Persistencia de categorías en SQLite; origen/adaptador para reglas de categoría y software.
class CategoriesServiceUse implements CategoriesServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  CategoryDataRule _categoryFromRow(CategoriesTableData row) =>
      CategoryAdapterUse.toDataRule(CategoryOriginUse.fromDrift(row));

  Future<int> _nextSiblingSortOrder(int? parentId) async {
    final q = _database.select(_database.categoriesTable);
    if (parentId == null) {
      q.where((t) => t.parentId.isNull());
    } else {
      q.where((t) => t.parentId.equals(parentId));
    }
    final siblings = await q.get();
    if (siblings.isEmpty) {
      return 0;
    }
    var max = siblings.first.sortOrder;
    for (final s in siblings.skip(1)) {
      if (s.sortOrder > max) {
        max = s.sortOrder;
      }
    }
    return max + 1;
  }

  List<CategoryDataRule> _hierarchyFromRows(List<CategoriesTableData> all) {
    final byParent = <int?, List<CategoriesTableData>>{};
    for (final c in all) {
      byParent.putIfAbsent(c.parentId, () => []).add(c);
    }
    for (final list in byParent.values) {
      list.sort((a, b) {
        final o = a.sortOrder.compareTo(b.sortOrder);
        if (o != 0) {
          return o;
        }
        return a.name.compareTo(b.name);
      });
    }
    final out = <CategoryDataRule>[];
    void walk(int? parentId) {
      final children = byParent[parentId] ?? [];
      for (final c in children) {
        out.add(_categoryFromRow(c));
        walk(c.id);
      }
    }

    walk(null);
    return out;
  }

  @override
  Future<ResponseRule<CategoryDataRule>> create(
    String name, {
    String? description,
    String? icon,
    int? parentId,
  }) async {
    try {
      if (parentId != null) {
        final parent = await (_database.select(_database.categoriesTable)
              ..where((t) => t.id.equals(parentId)))
            .getSingleOrNull();
        if (parent == null) {
          return const FailureResponseRule(message: 'Parent category not found.');
        }
      }
      final sortOrder = await _nextSiblingSortOrder(parentId);
      final inserted = await _database
          .into(_database.categoriesTable)
          .insertReturning(
            CategoriesTableCompanion.insert(
              name: name,
              description: description != null
                  ? Value(description)
                  : const Value.absent(),
              icon: icon != null ? Value(icon) : const Value.absent(),
              sortOrder: Value(sortOrder),
              parentId: parentId != null ? Value(parentId) : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _categoryFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> delete(int id) async {
    try {
      final n = await (_database.delete(_database.categoriesTable)
            ..where((t) => t.id.equals(id)))
          .go();
      if (n == 0) {
        return const FailureResponseRule(message: 'Category not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<CategoryDataRule>>> getAll({bool? rootOnly}) async {
    try {
      final q = _database.select(_database.categoriesTable);
      if (rootOnly == true) {
        q.where((t) => t.parentId.isNull());
      }
      q.orderBy([
        (t) => OrderingTerm.asc(t.sortOrder),
        (t) => OrderingTerm.asc(t.name),
      ]);
      final rows = await q.get();
      return SuccessResponseRule(
        data: rows.map(_categoryFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<CategoryDataRule>> getById(int id) async {
    try {
      final row = await (_database.select(_database.categoriesTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Category not found.');
      }
      return SuccessResponseRule(data: _categoryFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<CategoryDataRule>>> getChildren(int parentId) async {
    try {
      final parent = await (_database.select(_database.categoriesTable)
            ..where((t) => t.id.equals(parentId)))
          .getSingleOrNull();
      if (parent == null) {
        return const FailureResponseRule(message: 'Parent category not found.');
      }
      final rows = await (_database.select(_database.categoriesTable)
            ..where((t) => t.parentId.equals(parentId))
            ..orderBy([
              (t) => OrderingTerm.asc(t.sortOrder),
              (t) => OrderingTerm.asc(t.name),
            ]))
          .get();
      return SuccessResponseRule(
        data: rows.map(_categoryFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<CategoryDataRule>>> getHierarchy() async {
    try {
      final rows = await _database.select(_database.categoriesTable).get();
      return SuccessResponseRule(data: _hierarchyFromRows(rows));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> reorder(int categoryId, int newSortOrder) async {
    try {
      final n = await (_database.update(_database.categoriesTable)
            ..where((t) => t.id.equals(categoryId)))
          .write(
        CategoriesTableCompanion(
          sortOrder: Value(newSortOrder),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (n == 0) {
        return const FailureResponseRule(message: 'Category not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<CategoryDataRule>> update(
    int id, {
    String? name,
    String? description,
    String? icon,
  }) async {
    try {
      final existing = await (_database.select(_database.categoriesTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Category not found.');
      }
      await (_database.update(_database.categoriesTable)
            ..where((t) => t.id.equals(id)))
          .write(
        CategoriesTableCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          description: description != null
              ? Value(description)
              : const Value.absent(),
          icon: icon != null ? Value(icon) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      final updated = await (_database.select(_database.categoriesTable)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      return SuccessResponseRule(data: _categoryFromRow(updated));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }
}
