import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

abstract class InstallationServiceRule {
  /// Creates installations for manually selected software.
  /// Crea instalaciones para software seleccionado manualmente.
  Future<ApiResponseRule<List<InstallationsDataRule>>> createManualInstallations(
    List<int> softwareIds,
  );

  /// Creates an installation from a pack.
  /// Crea una instalación desde un pack.
  Future<ApiResponseRule<InstallationsDataRule>> createPackInstallation(
    int packId,
  );

  /// Starts an installation process.
  /// Inicia un proceso de instalación.
  Future<ApiResponseRule<Unit>> startInstallation(int installationId);

  /// Updates installation progress.
  /// Actualiza el progreso de la instalación.
  Future<ApiResponseRule<Unit>> updateProgress({
    required int installationId,
    required int progress,
  });

  /// Marks installation as completed.
  /// Marca la instalación como completada.
  Future<ApiResponseRule<Unit>> completeInstallation(int installationId);

  /// Marks installation as failed.
  /// Marca la instalación como fallida.
  Future<ApiResponseRule<Unit>> failInstallation({
    required int installationId,
    required String errorMessage,
  });

  /// Cancels an installation.
  /// Cancela una instalación.
  Future<ApiResponseRule<Unit>> cancelInstallation(int installationId);

  /// Retries a failed installation.
  /// Reintenta una instalación fallida.
  Future<ApiResponseRule<Unit>> retryInstallation(int installationId);

  /// Returns a specific installation.
  /// Devuelve una instalación específica.
  Future<ApiResponseRule<InstallationsDataRule>> getInstallationById(
    int installationId,
  );

  /// Lists all installations.
  /// Lista todas las instalaciones.
  Future<ApiResponseRule<List<InstallationsDataRule>>> listInstallations();
}
