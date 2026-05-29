import 'package:drift/drift.dart';

import 'installation_packs_table.dart';
import 'software_table.dart';

/// Immutable finished installation records with denormalized snapshots.
/// Registros inmutables de instalaciones finalizadas con snapshots desnormalizados.
@TableIndex(name: 'idx_history_completed', columns: {#completedAt})
@TableIndex(name: 'idx_history_status', columns: {#status})
@TableIndex(name: 'idx_history_software', columns: {#softwareId})
@TableIndex(name: 'idx_history_comp_st', columns: {#completedAt, #status})
class InstallationHistoryTable extends Table {
  @override
  String get tableName => 'installation_history';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Original software id when still present.
  IntColumn get softwareId => integer().nullable().references(
        SoftwareTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Pack id when the run belonged to a pack.
  IntColumn get packId => integer().nullable().references(
        InstallationPacksTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Software name snapshot (max 255).
  TextColumn get softwareName => text().withLength(max: 255)();

  /// Version snapshot (max 50).
  TextColumn get softwareVersion => text().withLength(max: 50).nullable()();

  /// Installer type snapshot (max 30).
  TextColumn get installerType => text().withLength(max: 30).nullable()();

  /// `success`, `failed`, or `cancelled` (plain text from rules).
  TextColumn get status => text()();

  /// Failure details.
  TextColumn get errorDetails => text().nullable()();

  /// Run start time.
  DateTimeColumn get startedAt => dateTime()();

  /// Run completion time.
  DateTimeColumn get completedAt => dateTime()();

  /// JSON snapshot of the machine that ran this installation.
  /// Keys: hostname, username, domain?, osVersion, processors, totalRamMb?.
  ///
  /// Snapshot JSON del equipo que ejecutó la instalación.
  TextColumn get machineInfo => text().nullable()();

  /// Row creation time.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
