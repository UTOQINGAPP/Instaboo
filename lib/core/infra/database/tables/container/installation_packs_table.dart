import 'package:drift/drift.dart';

/// User-defined installation packs (bundles).
/// Packs de instalación definidos por el usuario (conjuntos).
@TableIndex(name: 'idx_installation_packs_active', columns: {#isActive})
class InstallationPacksTable extends Table {
  @override
  String get tableName => 'installation_packs';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Unique pack name (max 200).
  TextColumn get name => text().withLength(max: 200).unique()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Icon reference (max 100).
  TextColumn get icon => text().withLength(max: 100).nullable()();

  /// Whether the pack is selectable.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
