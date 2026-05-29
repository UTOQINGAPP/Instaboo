import 'package:drift/drift.dart';

import 'installation_packs_table.dart';
import 'installers_table.dart';
import 'software_table.dart';

/// Active or pending installation queue rows (completed rows move to history).
/// Filas de cola de instalación activas o pendientes (al terminar pasan al historial).
@TableIndex(name: 'idx_queue_status', columns: {#status})
@TableIndex(name: 'idx_queue_position', columns: {#queuePosition})
class InstallationQueueTable extends Table {
  @override
  String get tableName => 'installation_queue';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Software being installed, if still linked.
  IntColumn get softwareId => integer().nullable().references(
        SoftwareTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Installer folder id in use.
  TextColumn get installerId => text()
      .withLength(max: 20)
      .nullable()
      .references(InstallersTable, #id, onDelete: KeyAction.setNull)();

  /// Pack context when enqueued from a pack.
  IntColumn get packId => integer().nullable().references(
        InstallationPacksTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Snapshot label for UI (max 255).
  TextColumn get displayName => text().withLength(max: 255)();

  /// `pending`, `queued`, `installing`, `paused`, `cancelled` (plain text from rules).
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();

  /// Progress 0–100.
  IntColumn get progress => integer().withDefault(const Constant(0))();

  /// Queue ordering hint.
  IntColumn get queuePosition => integer().nullable()();

  /// Last error message while in queue.
  TextColumn get errorMessage => text().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// When execution started.
  DateTimeColumn get startedAt => dateTime().nullable()();
}
