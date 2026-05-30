import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Installers consumer implementation. Delegates to [InstallersServiceRule].
/// Implementación del consumer de instaladores. Delega a [InstallersServiceRule].
class InstallersConsumerRule {

  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
final InstallersServiceRule _service;
  /// Constructor.
  /// Constructor.
  InstallersConsumerRule({required InstallersServiceRule service})
    : _service = service;

  /// Creates a new installer.
  /// Crea un nuevo instalador.
  Future<ResponseRule<InstallerDataRule>> create(
    String id,
    String contentType,
    String mainExecutable,
    {String? installerType, String? silentArgs, String? originalName}
  ) {
    return _service.create(id, contentType, mainExecutable, installerType: installerType, silentArgs: silentArgs, originalName: originalName);
  }
  
  /// Returns an installer by id.
  /// Devuelve un instalador por id.
  Future<ResponseRule<InstallerDataRule>> getById(String id) {
    return _service.getById(id);
  }
  
  /// Returns all installers.
  /// Devuelve todos los instaladores.
  Future<ResponseRule<List<InstallerDataRule>>> getAll() {
    return _service.getAll();
  }
  
  /// Deletes an installer.
  /// Elimina un instalador.
  Future<ResponseRule<Unit>> delete(String id) {
    return _service.delete(id);
  }
  
  /// Updates the metadata of an installer.
  /// Actualiza la metadata de un instalador.
  Future<ResponseRule<Unit>> updateMetadata(
    String id,
    {int? fileCount, int? totalSizeBytes, String? fileHashSha256}
  ) {
    return _service.updateMetadata(id, fileCount: fileCount, totalSizeBytes: totalSizeBytes, fileHashSha256: fileHashSha256);
  }
  
  /// Verifies the existence of files on disk and updates is_verified.
  /// Verifica la existencia de archivos en disco y actualiza is_verified.
  Future<ResponseRule<Unit>> verify(String id) {
    return _service.verify(id);
  }

  /// Integrity pre-flight (SEC-02): success = safe to execute; failure = do not launch.
  /// Pre-vuelo de integridad (SEC-02): éxito = seguro ejecutar; fallo = no lanzar.
  Future<ResponseRule<Unit>> checkIntegrity(String id) {
    return _service.checkIntegrity(id);
  }

  /// Returns the main executable path.
  /// Devuelve la ruta completa reconstruida: /installers/{id}/{main_executable}
  Future<ResponseRule<InstallerDataRule>> getMainExecutablePath(String id) {
    return _service.getMainExecutablePath(id);
  }
  
  /// Returns unused installers.
  /// Devuelve instaladores no referenciados por ningún software (candidatos a limpieza)
  Future<ResponseRule<List<InstallerDataRule>>> getUnused() {
    return _service.getUnused();
  }

  /// Registers a single-file installer by copying it into the managed installers tree.
  /// Registra un instalador de un solo archivo copiándolo al árbol de instaladores gestionado.
  Future<ResponseRule<InstallerDataRule>> importSingleFileFromPath(
    String sourceFilePath, {
    String? silentArgs,
  }) {
    return _service.importSingleFileFromPath(
      sourceFilePath,
      silentArgs: silentArgs,
    );
  }
}