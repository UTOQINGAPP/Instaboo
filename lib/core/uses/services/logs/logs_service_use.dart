import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Structured logs in SQLite and mirrored lines in the filesystem log folder.
/// Logs estructurados en SQLite y líneas espejo en la carpeta de logs en disco.
class LogsServiceUse implements LogsServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;
  final FilesystemInfra _filesystem = FilesystemInfra.instance;

  static const int _defaultRetentionDays = 30;

  LogDataRule _logFromRow(LogsTableData row) =>
      LogAdapterUse.toDataRule(LogOriginUse.fromDrift(row));

  String _flatFileLine(
    String level,
    String message, {
    String? context,
    String? referenceId,
  }) {
    final buf = StringBuffer('[$level]');
    if (context != null && context.isNotEmpty) {
      buf.write(' [$context]');
    }
    if (referenceId != null && referenceId.isNotEmpty) {
      buf.write(' ref=$referenceId');
    }
    buf.write(' $message');
    return buf.toString();
  }

  Future<ResponseRule<Unit>> _persistLog(
    String level,
    String message, {
    String? context,
    String? referenceId,
  }) async {
    try {
      await _database.into(_database.logsTable).insert(
            LogsTableCompanion.insert(
              message: message,
              level: Value(level),
              context: context != null ? Value(context) : const Value.absent(),
              referenceId: referenceId != null
                  ? Value(referenceId)
                  : const Value.absent(),
            ),
          );
      final now = DateTime.now();
      await _filesystem.writeLog(
        _flatFileLine(level, message, context: context, referenceId: referenceId),
        timestamp: now,
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<LogDataRule>>> getContextLogs(String context) async {
    try {
      final rows = await (_database.select(_database.logsTable)
            ..where((t) => t.context.equals(context))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
      return SuccessResponseRule(
        data: rows.map(_logFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<LogDataRule>>> getLogs({
    String? level,
    String? context,
    DateTime? fromDate,
    DateTime? toDate,
    int limit = 100,
  }) async {
    try {
      final safeLimit = limit.clamp(1, 10000);
      final rows = await (_database.select(_database.logsTable)
            ..where((t) {
              Expression<bool> e = const Constant(true);
              final lv = level;
              if (lv != null) {
                e = e & t.level.equals(lv);
              }
              final ctx = context;
              if (ctx != null) {
                e = e & t.context.equals(ctx);
              }
              final from = fromDate;
              if (from != null) {
                e = e & t.createdAt.isBiggerOrEqualValue(from);
              }
              final to = toDate;
              if (to != null) {
                e = e & t.createdAt.isSmallerOrEqualValue(to);
              }
              return e;
            })
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(safeLimit))
          .get();
      return SuccessResponseRule(
        data: rows.map(_logFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> cleanup({int? olderThanDays}) async {
    final days = olderThanDays ?? _defaultRetentionDays;
    if (days < 1) {
      return const FailureResponseRule(
        message: 'olderThanDays must be at least 1.',
      );
    }
    try {
      final cutoff = DateTime.now().subtract(Duration(days: days));
      await (_database.delete(_database.logsTable)
            ..where((t) => t.createdAt.isSmallerThanValue(cutoff)))
          .go();
      await _filesystem.deleteOldLogs(olderThanDays: days);
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> log(
    String message, {
    String level = 'info',
    String? context,
    String? referenceId,
  }) =>
      _persistLog(level, message, context: context, referenceId: referenceId);

  @override
  Future<ResponseRule<Unit>> logDebug(String message, {String? context}) =>
      _persistLog('debug', message, context: context);

  @override
  Future<ResponseRule<Unit>> logError(String message, {String? context}) =>
      _persistLog('error', message, context: context);

  @override
  Future<ResponseRule<Unit>> logInfo(String message, {String? context}) =>
      _persistLog('info', message, context: context);

  @override
  Future<ResponseRule<Unit>> logWarning(String message, {String? context}) =>
      _persistLog('warning', message, context: context);
}
