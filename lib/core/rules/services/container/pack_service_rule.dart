import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

abstract class PackServiceRule {
  /// Creates a new installation pack.
  /// Crea un nuevo pack de instalación.
  Future<ApiResponseRule<Unit>> createPack({
    required String name,
    String? description,
  });

  /// Updates pack information.
  /// Actualiza la información del pack.
  Future<ApiResponseRule<Unit>> updatePack({
    required int packId,
    String? name,
    String? description,
    bool? isActive,
  });

  /// Deletes a pack.
  /// Elimina un pack.
  Future<ApiResponseRule<Unit>> deletePack(int packId);

  /// Returns pack details.
  /// Devuelve los detalles del pack.
  Future<ApiResponseRule<InstallationPacksDataRule>> getPackById(int packId);

  /// Lists all available packs.
  /// Lista todos los packs disponibles.
  Future<ApiResponseRule<List<InstallationPacksDataRule>>> listPacks();

  /// Adds software to a pack.
  /// Añade software a un pack.
  Future<ApiResponseRule<Unit>> addSoftwareToPack({
    required int packId,
    required int softwareId,
    int sortOrder = 0,
  });

  /// Removes software from a pack.
  /// Elimina software de un pack.
  Future<ApiResponseRule<Unit>> removeSoftwareFromPack({
    required int packId,
    required int softwareId,
  });

  /// Returns all software contained in a pack.
  /// Devuelve todo el software contenido en un pack.
  Future<ApiResponseRule<List<SoftwareDataRule>>> getPackSoftware(int packId);
}
