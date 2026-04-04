import 'package:drift/drift.dart';

import '../../enums/enums_database.dart';
import 'installations_table.dart';

/// Application logs for debugging and auditing.
/// Logs de aplicación para depuración y auditoría.
///
/// Maps to PostgreSQL: application_logs
/// Mapea a PostgreSQL: application_logs
@TableIndex(name: 'idx_application_logs_log_level', columns: {#logLevel})
@TableIndex(name: 'idx_application_logs_created_at', columns: {#createdAt})
@TableIndex(
  name: 'idx_application_logs_installation_id',
  columns: {#installationId},
)
class ApplicationLogsTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Log level.
  TextColumn get logLevel =>
      textEnum<LogLevelEnumDatabase>().withDefault(const Constant('info'))();

  /// Log message.
  TextColumn get logMessage => text()();

  /// Optional context identifier.
  TextColumn get logContext => text().withLength(max: 255).nullable()();

  /// Optional reference to installation.
  IntColumn get installationId => integer().nullable().references(
    InstallationsTable,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
