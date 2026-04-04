import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

class PackConsumerRule {
  final PackServiceRule _service;

  PackConsumerRule({required PackServiceRule service}) : _service = service;

  @override
  Future<ApiResponseRule<Unit>> createPack({
    required String name,
    String? description,
  }) {
    return _service.createPack(name: name, description: description);
  }

  @override
  Future<ApiResponseRule<Unit>> addSoftwareToPack({
    required int packId,
    required int softwareId,
    int sortOrder = 0,
  }) {
    return _service.addSoftwareToPack(
      packId: packId,
      softwareId: softwareId,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> deletePack(int packId) {
    return _service.deletePack(packId);
  }

  @override
  Future<ApiResponseRule<InstallationPacksDataRule>> getPackById(int packId) {
    return _service.getPackById(packId);
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> getPackSoftware(int packId) {
    return _service.getPackSoftware(packId);
  }

  @override
  Future<ApiResponseRule<List<InstallationPacksDataRule>>> listPacks() {
    return _service.listPacks();
  }

  @override
  Future<ApiResponseRule<Unit>> removeSoftwareFromPack({
    required int packId,
    required int softwareId,
  }) {
    return _service.removeSoftwareFromPack(
      packId: packId,
      softwareId: softwareId,
    );
  }

  @override
  Future<ApiResponseRule<Unit>> updatePack({
    required int packId,
    String? name,
    String? description,
    bool? isActive,
  }) {
    return _service.updatePack(
      packId: packId,
      name: name,
      description: description,
      isActive: isActive,
    );
  }
}
