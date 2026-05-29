import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for installer framework type persistence.
/// Contrato para persistencia de tipos de framework de instalador.
abstract class InstallerFrameworksServiceRule {
  /// Returns all installer framework types ordered by sortOrder.
  /// Devuelve todos los tipos de framework ordenados por sortOrder.
  Future<ResponseRule<List<InstallerFrameworkDataRule>>> getAll();

  /// Returns a framework by id.
  /// Devuelve un framework por id.
  Future<ResponseRule<InstallerFrameworkDataRule>> getById(int id);

  /// Returns a framework by name (case-insensitive).
  /// Devuelve un framework por nombre (sin distinción de mayúsculas).
  Future<ResponseRule<InstallerFrameworkDataRule>> getByName(String name);

  /// Creates a new custom framework type.
  /// Crea un nuevo tipo de framework personalizado.
  Future<ResponseRule<InstallerFrameworkDataRule>> create({
    required String name,
    String? description,
    String silentArgs,
  });

  /// Updates a framework's name, description or silentArgs.
  /// Actualiza el nombre, descripción o args de un framework.
  Future<ResponseRule<InstallerFrameworkDataRule>> update(
    int id, {
    String? name,
    String? description,
    String? silentArgs,
  });

  /// Deletes a non-built-in framework. Fails if isBuiltIn is true.
  /// Elimina un framework no integrado. Falla si isBuiltIn es true.
  Future<ResponseRule<Unit>> delete(int id);
}
