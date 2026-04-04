import 'package:drift/drift.dart';

import '../../enums/enums_database.dart';
import 'installation_packs_table.dart';
import 'software_table.dart';

/// Installations table for tracking installation progress.
/// Tabla de instalaciones para seguimiento del progreso.
///
/// Maps to PostgreSQL: installations
/// Mapea a PostgreSQL: installations
@TableIndex(name: 'idx_installations_status', columns: {#status})
@TableIndex(name: 'idx_installations_software_id', columns: {#softwareId})
@TableIndex(name: 'idx_installations_pack_id', columns: {#packId})
@TableIndex(name: 'idx_installations_created_at', columns: {#createdAt})
@TableIndex(
  name: 'idx_installations_status_created_at',
  columns: {#status, #createdAt},
)
@TableIndex(name: 'idx_installations_queue_position', columns: {#queuePosition})
class InstallationsTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Source type: software or pack.
  TextColumn get sourceType => textEnum<InstallationSourceTypeEnumDatabase>()();

  /// Foreign key to software (when source_type = 'software').
  IntColumn get softwareId => integer().nullable().references(
    SoftwareTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Foreign key to pack (when source_type = 'pack').
  IntColumn get packId => integer().nullable().references(
    InstallationPacksTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Display name for the installation.
  TextColumn get displayName => text().withLength(max: 255)();

  /// Installation status.
  TextColumn get status => textEnum<InstallationStatusEnumDatabase>()
      .withDefault(const Constant('pending'))();

  /// Progress percentage (0-100).
  IntColumn get progress => integer().withDefault(const Constant(0))();

  /// Position in the installation queue.
  IntColumn get queuePosition => integer().nullable()();

  /// When installation started.
  DateTimeColumn get startedAt => dateTime().nullable()();

  /// When installation completed.
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// Error message if failed.
  TextColumn get errorMessage => text().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
