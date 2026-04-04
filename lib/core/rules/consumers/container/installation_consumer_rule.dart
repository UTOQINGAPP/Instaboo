import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

class InstallationConsumerRule {
  final InstallationServiceRule _service;

  InstallationConsumerRule({required InstallationServiceRule service})
    : _service = service;

  @override
  Future<ApiResponseRule<List<InstallationsDataRule>>>
  createManualInstallations(List<int> softwareIds) {
    return _service.createManualInstallations(softwareIds);
  }

  @override
  Future<ApiResponseRule<Unit>> cancelInstallation(int installationId) {
    return _service.cancelInstallation(installationId);
  }

  @override
  Future<ApiResponseRule<Unit>> completeInstallation(int installationId) {
    return _service.completeInstallation(installationId);
  }

  @override
  Future<ApiResponseRule<InstallationsDataRule>> createPackInstallation(
    int packId,
  ) {
    return _service.createPackInstallation(packId);
  }

  @override
  Future<ApiResponseRule<Unit>> failInstallation({
    required int installationId,
    required String errorMessage,
  }) {
    return _service.failInstallation(
      installationId: installationId,
      errorMessage: errorMessage,
    );
  }

  @override
  Future<ApiResponseRule<InstallationsDataRule>> getInstallationById(
    int installationId,
  ) {
    return _service.getInstallationById(installationId);
  }

  @override
  Future<ApiResponseRule<List<InstallationsDataRule>>> listInstallations() {
    return _service.listInstallations();
  }

  @override
  Future<ApiResponseRule<Unit>> retryInstallation(int installationId) {
    return _service.retryInstallation(installationId);
  }

  @override
  Future<ApiResponseRule<Unit>> startInstallation(int installationId) {
    return _service.startInstallation(installationId);
  }

  @override
  Future<ApiResponseRule<Unit>> updateProgress({
    required int installationId,
    required int progress,
  }) {
    return _service.updateProgress(
      installationId: installationId,
      progress: progress,
    );
  }
}
