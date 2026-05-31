import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Consumer for installer framework types. Delegates to [InstallerFrameworksServiceRule].
/// Consumer de tipos de framework de instalador. Delega a [InstallerFrameworksServiceRule].
class InstallerFrameworksConsumerRule {
  final InstallerFrameworksServiceRule _service;

  InstallerFrameworksConsumerRule({required InstallerFrameworksServiceRule service})
      : _service = service;

  /// Returns all installer framework types.
  /// Devuelve todos los tipos de framework de instalador.
  Future<ResponseRule<List<InstallerFrameworkDataRule>>> getAll() =>
      _service.getAll();

  /// Returns a framework by id.
  /// Devuelve un framework por id.
  Future<ResponseRule<InstallerFrameworkDataRule>> getById(int id) =>
      _service.getById(id);

  /// Returns a framework by name (case-insensitive).
  /// Devuelve un framework por nombre (sin distinción de mayúsculas).
  Future<ResponseRule<InstallerFrameworkDataRule>> getByName(String name) =>
      _service.getByName(name);

  /// Creates a new custom framework type.
  /// Crea un nuevo tipo de framework personalizado.
  Future<ResponseRule<InstallerFrameworkDataRule>> create({
    required String name,
    String? description,
    String silentArgs = '',
  }) =>
      _service.create(name: name, description: description, silentArgs: silentArgs);

  /// Updates a framework's details.
  /// Actualiza los detalles de un framework.
  Future<ResponseRule<InstallerFrameworkDataRule>> update(
    int id, {
    String? name,
    String? description,
    String? silentArgs,
  }) =>
      _service.update(id, name: name, description: description, silentArgs: silentArgs);

  /// Deletes a non-built-in framework.
  /// Elimina un framework no integrado.
  Future<ResponseRule<Unit>> delete(int id) => _service.delete(id);

  /// Detects the installer framework for the binary at [filePath].
  /// Returns null data when no framework is recognized.
  /// Detecta el framework del instalador para el binario en [filePath].
  Future<ResponseRule<InstallerFrameworkDataRule?>> detectForFile(
    String filePath,
  ) => _service.detectForFile(filePath);
}
