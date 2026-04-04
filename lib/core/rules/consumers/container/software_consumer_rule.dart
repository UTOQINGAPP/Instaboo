import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/enums/enums_rule.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

class SoftwareConsumerRule {
  final SoftwareServiceRule _service;

  SoftwareConsumerRule({required SoftwareServiceRule service})
    : _service = service;

  @override
  Future<ApiResponseRule<Unit>> createSoftware({
    required String name,
    required String slug,
    String? version,
    required int categoryId,
    String? description,
    String? logo,
    int? sizeMb,
    required InstallationTypeEnumRule installationType,
    required InstallerSourceTypeEnumRule installerSourceType,
    required String installerSource,
    String? silentArgs,
  }) {
    return _service.createSoftware(
      name: name,
      slug: slug,
      version: version,
      categoryId: categoryId,
      description: description,
      logo: logo,
      sizeMb: sizeMb,
      installationType: installationType,
      installerSourceType: installerSourceType,
      installerSource: installerSource,
      silentArgs: silentArgs,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> addDependency({
    required int softwareId,
    required int dependencySoftwareId,
    bool isRequired = true,
  }) {
    return _service.addDependency(
      softwareId: softwareId,
      dependencySoftwareId: dependencySoftwareId,
      isRequired: isRequired,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> deleteSoftware(int softwareId) {
    return _service.deleteSoftware(softwareId);
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId,
  ) {
    return _service.getDependencies(softwareId);
  }

  @override
  Future<ApiResponseRule<SoftwareDataRule>> getSoftwareById(int softwareId) {
    return _service.getSoftwareById(softwareId);
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> listSoftware() {
    return _service.listSoftware();
  }

  @override
  Future<ApiResponseRule<Unit>> removeDependency({
    required int softwareId,
    required int dependencySoftwareId,
  }) {
    return _service.removeDependency(
      softwareId: softwareId,
      dependencySoftwareId: dependencySoftwareId,
    );
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> searchSoftware(String query) {
    return _service.searchSoftware(query);
  }

  @override
  Future<ApiResponseRule<Unit>> updateSoftware({
    required int softwareId,
    String? name,
    String? version,
    String? description,
    String? logo,
    bool? isActive,
  }) {
    return _service.updateSoftware(
      softwareId: softwareId,
      name: name,
      version: version,
      description: description,
      logo: logo,
      isActive: isActive,
    );
  }
}
