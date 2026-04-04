import 'package:drift/drift.dart';

/// Categories table for software classification.
/// Tabla de categorías para clasificación de software.
///
/// Maps to PostgreSQL: categories
/// Mapea a PostgreSQL: categories
@TableIndex(name: 'idx_categories_name', columns: {#name})
class CategoriesTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Category name (unique).
  TextColumn get name => text().withLength(max: 100).unique()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Icon identifier (e.g. emoji or icon name).
  TextColumn get icon => text().withLength(max: 255).nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
