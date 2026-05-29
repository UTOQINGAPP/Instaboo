import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for dependency resolution and persistence.
/// Contrato para resolución y persistencia de dependencias.
abstract class DependenciesServiceRule {
  /// Creates a new dependency.
  /// Crea una nueva dependencia.
  Future<ResponseRule<DependencyDataRule>> addDependency(
    int softwareId,
    int dependencySoftwareId,
    {bool isRequired = true, String? notes}
  );
  
  /// Removes a dependency.
  /// Elimina una dependencia.
  Future<ResponseRule<Unit>> removeDependency(int softwareId, int dependencySoftwareId);
  
  /// Updates a dependency.
  /// Actualiza una dependencia.
  Future<ResponseRule<Unit>> updateDependency(
    int softwareId,
    int dependencySoftwareId,
    {bool? isRequired, String? notes}
  );
  
  /// Returns the dependencies of a software.
  /// Devuelve las dependencias de un software.
  Future<ResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId,
    {bool? onlyRequired}
  );
  
  /// Returns the dependents of a software.
  /// Devuelve los dependientes de un software.
  Future<ResponseRule<List<SoftwareDataRule>>> getDependents(int softwareId);
  
  /// Resolves the dependency tree.
  /// Resuelve el árbol de dependencias.
  Future<ResponseRule<List<SoftwareDataRule>>> resolveDependencyTree(int softwareId);
  
  /// Checks for circular dependencies.
  /// Verifica si hay dependencias circulares.
  Future<ResponseRule<bool>> checkCircularDependency(
    int softwareId,
    int potentialDependencyId
  );

}