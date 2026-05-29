import 'package:drift/drift.dart';

/// Structured application logs (high-volume debug should use flat files).
/// Logs estructurados de la app (debug de alto volumen en archivos planos).
@TableIndex(name: 'idx_logs_level', columns: {#level})
@TableIndex(name: 'idx_logs_created', columns: {#createdAt})
@TableIndex(name: 'idx_logs_context', columns: {#context})
class LogsTable extends Table {
  @override
  String get tableName => 'logs';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// `debug`, `info`, `warning`, or `error` (plain text from rules).
  TextColumn get level => text().withDefault(const Constant('info'))();

  /// Log body.
  TextColumn get message => text()();

  /// Module or area (max 100).
  TextColumn get context => text().withLength(max: 100).nullable()();

  /// Soft reference to any entity id (max 50).
  TextColumn get referenceId => text().withLength(max: 50).nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
