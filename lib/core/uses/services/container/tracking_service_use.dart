import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Tracking service use implementation. Delegates to infra (DatabaseInfra).
/// Uses [DatabaseInfra.installationHistoryTable], [DatabaseInfra.applicationLogsTable],
/// [InstallationHistoryAdapterUse] and [ApplicationLogsAdapterUse] for mapping.
///
/// Implementación del use de servicio de seguimiento. Delega en infra (DatabaseInfra).
/// Usa [DatabaseInfra.installationHistoryTable], [DatabaseInfra.applicationLogsTable],
/// [InstallationHistoryAdapterUse] y [ApplicationLogsAdapterUse] para el mapeo.
class TrackingServiceUse implements TrackingServiceRule {
  /// Database infrastructure instance.
  /// Instancia de infraestructura de base de datos.
  final DatabaseInfra _db = DatabaseInfra.instance;

  /// Creates the use with optional database instance (for testing).
  /// Crea el use con instancia de base de datos opcional (para pruebas).
  TrackingServiceUse();

  @override
  Future<ApiResponseRule<Unit>> createHistoryEntry({
    required int installationId,
    required int softwareId,
    required String softwareName,
    required HistoryStatusEnumRule status,
    int? durationSeconds,
    String? errorDetails,
  }) async {
    try {
      await _db.into(_db.installationHistoryTable).insert(
            InstallationHistoryTableCompanion.insert(
              softwareName: softwareName,
              status: HistoryStatusEnumDatabase.values.byName(status.name),
              installationId: Value(installationId),
              softwareId: Value(softwareId),
              durationSeconds: Value(durationSeconds),
              errorDetails: Value(errorDetails),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CREATE_HISTORY_ENTRY',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<InstallationHistoryDataRule>>>
  listInstallationHistory() async {
    try {
      final rows = await (_db.select(_db.installationHistoryTable)
            ..orderBy([
              (t) => OrderingTerm.desc(t.installationDate),
              (t) => OrderingTerm.desc(t.id),
            ]))
          .get();
      final list = rows
          .map(
            (row) => InstallationHistoryAdapterUse.fromOrigin(
              InstallationHistoryDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'LIST_INSTALLATION_HISTORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<InstallationStatisticsDataRule>>
  getInstallationStatistics() async {
    try {
      final rows = await _db.select(_db.installationHistoryTable).get();
      final totalCount = rows.length;
      final successCount = rows
          .where(
            (r) => r.status == HistoryStatusEnumDatabase.success,
          )
          .length;
      final failedCount = rows
          .where(
            (r) => r.status == HistoryStatusEnumDatabase.failed,
          )
          .length;
      final cancelledCount = rows
          .where(
            (r) => r.status == HistoryStatusEnumDatabase.cancelled,
          )
          .length;

      final durations = rows
          .where((r) => r.durationSeconds != null)
          .map((r) => r.durationSeconds!);
      double? averageDurationSeconds;
      if (durations.isNotEmpty) {
        averageDurationSeconds =
            durations.reduce((a, b) => a + b) / durations.length;
      }

      DateTime? lastInstallationDate;
      if (rows.isNotEmpty) {
        lastInstallationDate = rows
            .map((r) => r.installationDate)
            .reduce(
              (a, b) => a.isAfter(b) ? a : b,
            );
      }

      final stats = InstallationStatisticsDataRule(
        totalCount: totalCount,
        successCount: successCount,
        failedCount: failedCount,
        cancelledCount: cancelledCount,
        averageDurationSeconds: averageDurationSeconds,
        lastInstallationDate: lastInstallationDate,
      );
      return SuccessResponseRule(data: stats);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_INSTALLATION_STATISTICS',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> createLog({
    required LogLevelEnumRule level,
    required String message,
    String? context,
    int? installationId,
  }) async {
    try {
      await _db.into(_db.applicationLogsTable).insert(
            ApplicationLogsTableCompanion.insert(
              logMessage: message,
              logLevel: Value(
                LogLevelEnumDatabase.values.byName(level.name),
              ),
              logContext: Value(context),
              installationId: Value(installationId),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CREATE_LOG',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> getLogsByInstallation(
    int installationId,
  ) async {
    try {
      final rows = await (_db.select(_db.applicationLogsTable)
            ..where((t) => t.installationId.equals(installationId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
      final list = rows
          .map(
            (row) => ApplicationLogsAdapterUse.fromOrigin(
              ApplicationLogsDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_LOGS_BY_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> listLogs() async {
    try {
      final rows = await (_db.select(_db.applicationLogsTable)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
      final list = rows
          .map(
            (row) => ApplicationLogsAdapterUse.fromOrigin(
              ApplicationLogsDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'LIST_LOGS',
      );
    }
  }
}
