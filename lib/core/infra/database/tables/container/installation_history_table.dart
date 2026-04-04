import 'package:drift/drift.dart';

import '../../enums/enums_database.dart';
import 'installations_table.dart';
import 'software_table.dart';

/// Installation history for reports and auditing.
/// Historial de instalaciones para reportes y auditoría.
///
/// Maps to PostgreSQL: installation_history
/// Mapea a PostgreSQL: installation_history
@TableIndex(
  name: 'idx_installation_history_installation_date',
  columns: {#installationDate},
)
@TableIndex(
  name: 'idx_installation_history_software_id',
  columns: {#softwareId},
)
@TableIndex(name: 'idx_installation_history_status', columns: {#status})
@TableIndex(
  name: 'idx_installation_history_date_status',
  columns: {#installationDate, #status},
)
class InstallationHistoryTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to installations (nullable if installation record was deleted).
  IntColumn get installationId => integer().nullable().references(
    InstallationsTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Foreign key to software.
  IntColumn get softwareId => integer().nullable().references(
    SoftwareTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Software name at time of installation (denormalized for history).
  TextColumn get softwareName => text().withLength(max: 255)();

  /// When the installation occurred.
  DateTimeColumn get installationDate =>
      dateTime().withDefault(currentDateAndTime)();

  /// Final status: success, failed, or cancelled.
  TextColumn get status => textEnum<HistoryStatusEnumDatabase>()();

  /// Duration in seconds (nullable).
  IntColumn get durationSeconds => integer().nullable()();

  /// Error details if failed.
  TextColumn get errorDetails => text().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
