import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/enums/enums_rule.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

abstract class TrackingServiceRule {
  /// Creates an entry in installation history.
  /// Crea una entrada en el historial de instalación.
  Future<ApiResponseRule<Unit>> createHistoryEntry({
    required int installationId,
    required int softwareId,
    required String softwareName,
    required HistoryStatusEnumRule status,
    int? durationSeconds,
    String? errorDetails,
  });

  /// Returns installation history.
  /// Devuelve el historial de instalación.
  Future<ApiResponseRule<List<InstallationHistoryDataRule>>>
      listInstallationHistory();

  /// Returns statistics of installations.
  /// Devuelve estadísticas de instalaciones.
  Future<ApiResponseRule<InstallationStatisticsDataRule>>
      getInstallationStatistics();

  /// Creates an application log entry.
  /// Crea una entrada de log de la aplicación.
  Future<ApiResponseRule<Unit>> createLog({
    required LogLevelEnumRule level,
    required String message,
    String? context,
    int? installationId,
  });

  /// Returns logs related to an installation.
  /// Devuelve los logs relacionados con una instalación.
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> getLogsByInstallation(
    int installationId,
  );

  /// Returns recent application logs.
  /// Devuelve los logs recientes de la aplicación.
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> listLogs();
}
