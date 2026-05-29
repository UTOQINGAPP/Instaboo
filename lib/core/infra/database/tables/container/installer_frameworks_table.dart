import 'package:drift/drift.dart';

/// Framework types for silent installer argument profiles.
/// Tipos de frameworks para perfiles de argumentos silenciosos.
@TableIndex(name: 'idx_installer_frameworks_name', columns: {#name})
class InstallerFrameworksTable extends Table {
  @override
  String get tableName => 'installer_frameworks';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Display name (e.g. "NSIS", "Inno Setup"). Unique.
  /// Nombre mostrado. Único.
  TextColumn get name => text().withLength(max: 100).unique()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Space-separated silent installer arguments for this framework.
  /// Argumentos silenciosos separados por espacio para este framework.
  TextColumn get silentArgs => text().withDefault(const Constant(''))();

  /// Whether this is a built-in (non-deletable) framework entry.
  /// Si es un registro integrado (no eliminable).
  BoolColumn get isBuiltIn =>
      boolean().withDefault(const Constant(false))();

  /// Display order.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
