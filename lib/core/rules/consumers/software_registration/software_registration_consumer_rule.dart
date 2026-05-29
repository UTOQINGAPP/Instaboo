import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Software-registration consumer. Delegates to [SoftwareRegistrationServiceRule].
/// Consumer de registro de software. Delega a [SoftwareRegistrationServiceRule].
class SoftwareRegistrationConsumerRule {
  final SoftwareRegistrationServiceRule _service;

  SoftwareRegistrationConsumerRule({required SoftwareRegistrationServiceRule service})
      : _service = service;

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
  }) {
    return _service.createWithAssets(
      name: name,
      slug: slug,
      version: version,
      description: description,
      categoryId: categoryId,
      isAutoInstallable: isAutoInstallable,
      requiresInternet: requiresInternet,
      installerFrameworkId: installerFrameworkId,
      extraSilentArgs: extraSilentArgs,
      iconSourcePath: iconSourcePath,
      installerSourcePath: installerSourcePath,
      silentArgs: silentArgs,
    );
  }
}
