import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Packs consumer implementation. Delegates to [PacksServiceRule].
/// Implementación del consumer de packs. Delega a [PacksServiceRule].
class PacksConsumerRule {

  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final PacksServiceRule _service;

  /// Constructor.
  /// Constructor.
  PacksConsumerRule({required PacksServiceRule service})
    : _service = service;

  /// Creates a new pack.
  /// Crea un nuevo pack.
  Future<ResponseRule<PackDataRule>> create(
    String name,
    {String? description, String? icon}
  ) {
    return _service.create(name, description: description, icon: icon);
  }
  
  /// Returns a pack by id.
  /// Devuelve un pack por id.
  Future<ResponseRule<PackDataRule>> getById(int id) {
    return _service.getById(id);
  }
  
  /// Returns all packs.
  /// Devuelve todos los packs.
  Future<ResponseRule<List<PackDataRule>>> getAll({bool? activeOnly}) {
    return _service.getAll(activeOnly: activeOnly);
  }
  
  /// Updates a pack.
  /// Actualiza un pack.
  Future<ResponseRule<PackDataRule>> update(
    int id,
    {String? name, String? description, String? icon}
  ) {
    return _service.update(id, name: name, description: description, icon: icon);
  }
  
  /// Deletes a pack.
  /// Elimina un pack.
  Future<ResponseRule<Unit>> delete(int id) {
    return _service.delete(id);
  }
  
  /// Toggles the active status of a pack.
  /// Cambia el estado activo de un pack.
  Future<ResponseRule<Unit>> toggleActive(int id, bool isActive) {
    return _service.toggleActive(id, isActive);
  }
  
  /// Adds software to a pack.
  /// Añade software a un pack.
  Future<ResponseRule<Unit>> addSoftware(int packId, int softwareId, int sortOrder) {
    return _service.addSoftware(packId, softwareId, sortOrder);
  }
  /// Removes software from a pack.
  /// Elimina software de un pack.
  Future<ResponseRule<Unit>> removeSoftware(int packId, int softwareId) {
    return _service.removeSoftware(packId, softwareId);
  }
  /// Reorders software in a pack.
  /// Reordena software en un pack.
  Future<ResponseRule<Unit>> reorderSoftware(int packId, int softwareId, int newSortOrder) {
    return _service.reorderSoftware(packId, softwareId, newSortOrder);
  }
  
  /// Returns the software in a pack.
  /// Devuelve el software en un pack.
  Future<ResponseRule<List<SoftwareDataRule>>> getSoftwareInPack(int packId) {
    return _service.getSoftwareInPack(packId);
  }
  /// Returns the detail of a pack.
  /// Devuelve el detalle de un pack.
  Future<ResponseRule<PackDetailDataRule>> getPackDetail(int packId) {
    return _service.getPackDetail(packId);
  }

}