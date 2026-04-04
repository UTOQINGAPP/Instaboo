import 'package:drift/drift.dart';

/// Installation packs table (bundles of software).
/// Tabla de packs de instalación (paquetes de software).
///
/// Maps to PostgreSQL: installation_packs
/// Mapea a PostgreSQL: installation_packs
@TableIndex(name: 'idx_installation_packs_is_active', columns: {#isActive})
class InstallationPacksTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Pack name (unique).
  TextColumn get name => text().withLength(max: 255).unique()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Whether the pack is active.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
