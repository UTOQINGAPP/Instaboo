import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for the software full-registration workflow.
/// Contrato para el flujo completo de registro de software.
abstract class SoftwareRegistrationServiceRule {
  /// Creates a software entry with optional icon and installer assets.
  /// Crea una entrada de software con icono e instalador opcionales.
  Future<ResponseRule<SoftwareDataRule>> createWithAssets({
    required String name,
    required String slug,
    String? version,
    String? description,
    int? categoryId,
    bool isAutoInstallable = true,
    bool requiresInternet = false,
    int? installerFrameworkId,
    String? extraSilentArgs,
    String? iconSourcePath,
    String? installerSourcePath,
    String? silentArgs,
  });
}
