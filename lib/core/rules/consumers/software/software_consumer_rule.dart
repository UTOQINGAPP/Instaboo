import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Software consumer implementation. Delegates to [SoftwareServiceRule].
/// Implementacion del consumer de software. Delega a [SoftwareServiceRule].
class SoftwareConsumerRule {
  final SoftwareServiceRule _service;

  SoftwareConsumerRule({required SoftwareServiceRule service})
    : _service = service;

  Future<ResponseRule<SoftwareDataRule>> create(
    String name,
    String slug,
    {String? version, String? description, int? categoryId,
     bool isAutoInstallable = true, bool requiresInternet = false,
     int? installerFrameworkId, String? extraSilentArgs}
  ) {
    return _service.create(name, slug,
      version: version, description: description, categoryId: categoryId,
      isAutoInstallable: isAutoInstallable, requiresInternet: requiresInternet,
      installerFrameworkId: installerFrameworkId, extraSilentArgs: extraSilentArgs);
  }

  Future<ResponseRule<SoftwareDataRule>> getById(int id) =>
      _service.getById(id);

  Future<ResponseRule<List<SoftwareDataRule>>> getAll({int? categoryId, bool? activeOnly}) =>
      _service.getAll(categoryId: categoryId, activeOnly: activeOnly);

  Future<ResponseRule<List<SoftwareDataRule>>> getByIds(List<int> ids) =>
      _service.getByIds(ids);

  Future<ResponseRule<SoftwareDataRule>> getBySlug(String slug) =>
      _service.getBySlug(slug);

  Future<ResponseRule<SoftwareDataRule>> update(
    int id,
    {String? name, String? version, String? description, int? categoryId,
     bool? isAutoInstallable, bool? requiresInternet,
     int? installerFrameworkId, String? extraSilentArgs}
  ) {
    return _service.update(id,
      name: name, version: version, description: description, categoryId: categoryId,
      isAutoInstallable: isAutoInstallable, requiresInternet: requiresInternet,
      installerFrameworkId: installerFrameworkId, extraSilentArgs: extraSilentArgs);
  }

  Future<ResponseRule<Unit>> delete(int id) => _service.delete(id);

  Future<ResponseRule<Unit>> setInstaller(int softwareId, String installerId) =>
      _service.setInstaller(softwareId, installerId);

  Future<ResponseRule<Unit>> removeInstaller(int softwareId) =>
      _service.removeInstaller(softwareId);

  Future<ResponseRule<Unit>> setIcon(int softwareId, String iconFilename) =>
      _service.setIcon(softwareId, iconFilename);

  Future<ResponseRule<Unit>> importIconFromPath(int softwareId, String sourceFilePath) =>
      _service.importIconFromPath(softwareId, sourceFilePath);

  Future<ResponseRule<Unit>> toggleActive(int softwareId, bool isActive) =>
      _service.toggleActive(softwareId, isActive);

  Future<ResponseRule<List<SoftwareDataRule>>> search(String query) =>
      _service.search(query);

  Future<ResponseRule<List<SoftwareDataRule>>> filterByArchitecture(String architecture) =>
      _service.filterByArchitecture(architecture);

  List<SoftwareDataRule> searchInMemory(List<SoftwareDataRule> items, String query) =>
      _service.searchInMemory(items, query);

  InstalledSoftwareInfoRule? findBestMatchInList(
    List<InstalledSoftwareInfoRule> items,
    String softwareName,
  ) => _service.findBestMatchInList(items, softwareName);

  // ── Filesystem paths ────────────────────────────────────────────────────────

  String getIconPath(String iconFilename) =>
      _service.getIconPath(iconFilename);

  // ── Windows Registry ────────────────────────────────────────────────────────

  Future<ResponseRule<List<InstalledSoftwareInfoRule>>> getInstalledFromRegistry({
    bool forceRefresh = false,
  }) => _service.getInstalledFromRegistry(forceRefresh: forceRefresh);

  Future<ResponseRule<InstalledSoftwareInfoRule?>> findMatchInRegistry(
    String softwareName,
  ) => _service.findMatchInRegistry(softwareName);

  void invalidateRegistryCache() => _service.invalidateRegistryCache();
}
