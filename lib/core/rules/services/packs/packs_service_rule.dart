import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for pack resolution and persistence.
/// Contrato para resolución y persistencia de packs.
abstract class PacksServiceRule {
  /// Creates a new pack.
  /// Crea un nuevo pack.
  Future<ResponseRule<PackDataRule>> create(
    String name,
    {String? description, String? icon}
  );
  
  /// Returns a pack by id.
  /// Devuelve un pack por id.
  Future<ResponseRule<PackDataRule>> getById(int id);
  
  /// Returns all packs.
  /// Devuelve todos los packs.
  Future<ResponseRule<List<PackDataRule>>> getAll({bool? activeOnly});
  
  /// Updates a pack.
  /// Actualiza un pack.
  Future<ResponseRule<PackDataRule>> update(
    int id,
    {String? name, String? description, String? icon}
  );
  
  /// Deletes a pack.
  /// Elimina un pack.
  Future<ResponseRule<Unit>> delete(int id);
  
  /// Toggles the active status of a pack.
  /// Cambia el estado activo de un pack.
  Future<ResponseRule<Unit>> toggleActive(int id, bool isActive);
  
  /// Adds software to a pack.
  /// Añade software a un pack.
  Future<ResponseRule<Unit>> addSoftware(int packId, int softwareId, int sortOrder);
  /// Removes software from a pack.
  /// Elimina software de un pack.
  Future<ResponseRule<Unit>> removeSoftware(int packId, int softwareId);
  /// Reorders software in a pack.
  /// Reordena software en un pack.
  Future<ResponseRule<Unit>> reorderSoftware(int packId, int softwareId, int newSortOrder);
  
  /// Returns the software in a pack.
  /// Devuelve el software en un pack.
  Future<ResponseRule<List<SoftwareDataRule>>> getSoftwareInPack(int packId);
  /// Returns the detail of a pack.
  /// Devuelve el detalle de un pack.
  Future<ResponseRule<PackDetailDataRule>> getPackDetail(int packId);

}