import 'package:drift/drift.dart';

/// Hierarchical categories for software classification.
/// Categorías jerárquicas para clasificación de software.
@TableIndex(name: 'idx_categories_parent', columns: {#parentId})
class CategoriesTable extends Table {
  @override
  String get tableName => 'categories';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Unique category name (max 100 chars).
  TextColumn get name => text().withLength(max: 100).unique()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Icon name or visual reference (max 100 chars, not a file path).
  TextColumn get icon => text().withLength(max: 100).nullable()();

  /// Sort order among siblings.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Optional parent category.
  IntColumn get parentId => integer().nullable().references(
        CategoriesTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
