import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Dependencies consumer implementation. Delegates to [DependenciesServiceRule].
/// Implementación del consumer de dependencias. Delega a [DependenciesServiceRule].
class DependenciesConsumerRule {

  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final DependenciesServiceRule _service;

  /// Constructor.
  /// Constructor.
  DependenciesConsumerRule({required DependenciesServiceRule service})
    : _service = service;

  /// Creates a new dependency.
  /// Crea una nueva dependencia.
  Future<ResponseRule<DependencyDataRule>> addDependency(
    int softwareId,
    int dependencySoftwareId,
    {bool isRequired = true, String? notes}
  ) {
    return _service.addDependency(softwareId, dependencySoftwareId, isRequired: isRequired, notes: notes);
  }
  
  /// Removes a dependency.
  /// Elimina una dependencia.
  Future<ResponseRule<Unit>> removeDependency(int softwareId, int dependencySoftwareId) {
    return _service.removeDependency(softwareId, dependencySoftwareId);
  }
  
  /// Updates a dependency.
  /// Actualiza una dependencia.
  Future<ResponseRule<Unit>> updateDependency(
    int softwareId,
    int dependencySoftwareId,
    {bool? isRequired, String? notes}
  ) {
    return _service.updateDependency(softwareId, dependencySoftwareId, isRequired: isRequired, notes: notes);
  }
  
  /// Returns the dependencies of a software.
  /// Devuelve las dependencias de un software.
  Future<ResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId,
    {bool? onlyRequired}
  ) {
    return _service.getDependencies(softwareId, onlyRequired: onlyRequired);
  }
  
  /// Returns the dependents of a software.
  /// Devuelve los dependientes de un software.
  Future<ResponseRule<List<SoftwareDataRule>>> getDependents(int softwareId) {
    return _service.getDependents(softwareId);
  }
  
  /// Resolves the dependency tree.
  /// Resuelve el árbol de dependencias.
  Future<ResponseRule<List<SoftwareDataRule>>> resolveDependencyTree(int softwareId) {
    return _service.resolveDependencyTree(softwareId);
  }
  
  /// Checks for circular dependencies.
  /// Verifica si hay dependencias circulares.
  Future<ResponseRule<bool>> checkCircularDependency(
    int softwareId,
    int potentialDependencyId
  ) {
    return _service.checkCircularDependency(softwareId, potentialDependencyId);
  }

}