import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/enums/enums_rule.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

abstract class SoftwareServiceRule {
  /// Registers a new software in the library.
  /// Registra un nuevo software en la biblioteca.
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
  });

  /// Updates an existing software.
  /// Actualiza un software existente.
  Future<ApiResponseRule<Unit>> updateSoftware({
    required int softwareId,
    String? name,
    String? version,
    String? description,
    String? logo,
    bool? isActive,
  });

  /// Removes a software from the catalog.
  /// Elimina un software del catálogo.
  Future<ApiResponseRule<Unit>> deleteSoftware(int softwareId);

  /// Returns a software by id.
  /// Devuelve un software por id.
  Future<ApiResponseRule<SoftwareDataRule>> getSoftwareById(int softwareId);

  /// Lists all software available in the library.
  /// Lista todo el software disponible en la biblioteca.
  Future<ApiResponseRule<List<SoftwareDataRule>>> listSoftware();

  /// Searches software by text.
  /// Busca software por texto.
  Future<ApiResponseRule<List<SoftwareDataRule>>> searchSoftware(String query);

  /// Adds a dependency between two software items.
  /// Añade una dependencia entre dos software.
  Future<ApiResponseRule<Unit>> addDependency({
    required int softwareId,
    required int dependencySoftwareId,
    bool isRequired = true,
  });

  /// Removes a dependency.
  /// Elimina una dependencia.
  Future<ApiResponseRule<Unit>> removeDependency({
    required int softwareId,
    required int dependencySoftwareId,
  });

  /// Returns dependencies of a software.
  /// Devuelve las dependencias de un software.
  Future<ApiResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId,
  );
}
