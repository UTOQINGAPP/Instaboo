import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/enums/enums_rule.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

class TrackingConsumerRule {
  final TrackingServiceRule _service;

  TrackingConsumerRule({required TrackingServiceRule service})
    : _service = service;

  @override
  Future<ApiResponseRule<Unit>> createHistoryEntry({
    required int installationId,
    required int softwareId,
    required String softwareName,
    required HistoryStatusEnumRule status,
    int? durationSeconds,
    String? errorDetails,
  }) {
    return _service.createHistoryEntry(
      installationId: installationId,
      softwareId: softwareId,
      softwareName: softwareName,
      status: status,
      durationSeconds: durationSeconds,
      errorDetails: errorDetails,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> createLog({
    required LogLevelEnumRule level,
    required String message,
    String? context,
    int? installationId,
  }) {
    return _service.createLog(
      level: level,
      message: message,
      context: context,
      installationId: installationId,
    );
  }

  @override
  Future<ApiResponseRule<InstallationStatisticsDataRule>>
  getInstallationStatistics() {
    return _service.getInstallationStatistics();
  }

  @override
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> getLogsByInstallation(
    int installationId,
  ) {
    return _service.getLogsByInstallation(installationId);
  }

  @override
  Future<ApiResponseRule<List<InstallationHistoryDataRule>>>
  listInstallationHistory() {
    return _service.listInstallationHistory();
  }

  @override
  Future<ApiResponseRule<List<ApplicationLogsDataRule>>> listLogs() {
    return _service.listLogs();
  }
}
