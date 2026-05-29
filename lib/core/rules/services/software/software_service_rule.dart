import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for software resolution and persistence.
/// Contrato para resolucion y persistencia de software.
abstract class SoftwareServiceRule {
  /// Creates a new software.
  Future<ResponseRule<SoftwareDataRule>> create(
    String name,
    String slug,
    {String? version, String? description, int? categoryId,
     bool isAutoInstallable = true, bool requiresInternet = false,
     int? installerFrameworkId, String? extraSilentArgs}
  );

  /// Returns a software by id.
  Future<ResponseRule<SoftwareDataRule>> getById(int id);

  /// Returns all software.
  Future<ResponseRule<List<SoftwareDataRule>>> getAll({int? categoryId, bool? activeOnly});

  /// Returns a software by slug.
  Future<ResponseRule<SoftwareDataRule>> getBySlug(String slug);

  /// Updates a software.
  Future<ResponseRule<SoftwareDataRule>> update(
    int id,
    {String? name, String? version, String? description, int? categoryId,
     bool? isAutoInstallable, bool? requiresInternet,
     int? installerFrameworkId, String? extraSilentArgs}
  );

  /// Deletes a software.
  Future<ResponseRule<Unit>> delete(int id);

  /// Sets an installer for a software.
  Future<ResponseRule<Unit>> setInstaller(int softwareId, String installerId);

  /// Removes an installer from a software.
  Future<ResponseRule<Unit>> removeInstaller(int softwareId);

  /// Sets an icon for a software.
  Future<ResponseRule<Unit>> setIcon(int softwareId, String iconFilename);

  /// Copies an image from [sourceFilePath] into the managed icons folder and assigns it.
  Future<ResponseRule<Unit>> importIconFromPath(
    int softwareId,
    String sourceFilePath,
  );

  /// Toggles the active status of a software.
  Future<ResponseRule<Unit>> toggleActive(int softwareId, bool isActive);

  /// Searches for software.
  Future<ResponseRule<List<SoftwareDataRule>>> search(String query);

  /// Filters software by architecture.
  Future<ResponseRule<List<SoftwareDataRule>>> filterByArchitecture(String architecture);
}
