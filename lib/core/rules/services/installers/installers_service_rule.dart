import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for installer resolution and persistence.
/// Contrato para resolución y persistencia de instaladores.
abstract class InstallersServiceRule {
  /// Creates a new installer.
  /// Crea un nuevo instalador.
  Future<ResponseRule<InstallerDataRule>> create(
    String id,
    String contentType,
    String mainExecutable,
    {String? installerType, String? silentArgs, String? originalName}
  );
  
  /// Returns an installer by id.
  /// Devuelve un instalador por id.
  Future<ResponseRule<InstallerDataRule>> getById(String id);
  
  /// Returns all installers.
  /// Devuelve todos los instaladores.
  Future<ResponseRule<List<InstallerDataRule>>> getAll();
  
  /// Deletes an installer.
  /// Elimina un instalador.
  Future<ResponseRule<Unit>> delete(String id);
  
  /// Updates the metadata of an installer.
  /// Actualiza la metadata de un instalador.
  Future<ResponseRule<Unit>> updateMetadata(
    String id,
    {int? fileCount, int? totalSizeBytes, String? fileHashSha256}
  );
  
  /// Verifies the existence of files on disk and updates is_verified.
  /// Verifica la existencia de archivos en disco y actualiza is_verified.
  Future<ResponseRule<Unit>> verify(String id);

  /// Integrity pre-flight (SEC-02): recomputes the main executable SHA-256 and
  /// compares it to the stored baseline. Success means it is safe to execute
  /// (matching hash, or trust-on-first-use when no baseline exists yet);
  /// failure means the binary must NOT be launched.
  ///
  /// Pre-vuelo de integridad (SEC-02): recalcula el SHA-256 del ejecutable
  /// principal y lo compara con la línea base. Éxito = seguro ejecutar (hash
  /// coincide, o confianza en el primer uso si no hay línea base); fallo = el
  /// binario NO debe lanzarse.
  Future<ResponseRule<Unit>> checkIntegrity(String id);

  /// Returns the main executable path.
  /// Devuelve la ruta completa reconstruida: /installers/{id}/{main_executable}
  Future<ResponseRule<InstallerDataRule>> getMainExecutablePath(String id);
  
  /// Returns unused installers.
  /// Devuelve instaladores no referenciados por ningún software (candidatos a limpieza)
  Future<ResponseRule<List<InstallerDataRule>>> getUnused();

  /// Copies a single installer file into `/installers/{id}/` and persists the row.
  /// Copia un único archivo de instalador en `/installers/{id}/` y persiste la fila.
  ///
  /// [sourceFilePath] Absolute or relative path to the .exe / .msi file. / Ruta al .exe / .msi.
  /// [silentArgs] Optional silent-install arguments stored with the installer. / Argumentos silenciosos opcionales.
  Future<ResponseRule<InstallerDataRule>> importSingleFileFromPath(
    String sourceFilePath, {
    String? silentArgs,
  });

  // ── Business rules ──────────────────────────────────────────────────────────

  /// Resolves the effective silent args for an installation using the priority chain:
  ///   1. [explicitSilentArgs] — caller-provided, highest priority
  ///   2. Framework args + [extraSilentArgs] — from the installer framework
  ///   3. `default_silent_args` global setting — lowest priority
  ///
  /// Returns null when no silent args apply.
  /// interface/ must NOT re-implement this priority chain.
  ///
  /// Resuelve los silent args efectivos con la cadena de prioridad:
  ///   1. explicitSilentArgs — del caller, máxima prioridad
  ///   2. Args del framework + extraSilentArgs
  ///   3. Setting global default_silent_args — mínima prioridad
  Future<ResponseRule<String?>> resolveEffectiveSilentArgs({
    int? frameworkId,
    String? extraSilentArgs,
    String? explicitSilentArgs,
  });

  /// Builds the process argument list for launching an installer.
  ///
  /// When [isAutoInstallable] is false, returns an empty list (interactive install).
  /// Otherwise parses [installerId]'s silentArgs splitting by whitespace.
  ///
  /// Construye la lista de argumentos para lanzar el instalador.
  /// Si [isAutoInstallable] es false, devuelve lista vacía (instalación interactiva).
  Future<ResponseRule<List<String>>> buildProcessArgs(
    String installerId,
    bool isAutoInstallable,
  );

  // ── Filesystem paths ────────────────────────────────────────────────────────

  /// Returns the absolute path to the main executable of an installer.
  /// Pure path computation — synchronous and cannot fail.
  /// Devuelve la ruta absoluta al ejecutable principal de un instalador.
  String getExecutablePath(String installerId, String mainExecutable);

  // ── Authenticode ────────────────────────────────────────────────────────────

  /// Verifies the Authenticode (digital) signature of the file at [exePath].
  /// Never fails — returns [AuthenticodeCheckStatus.unknown] on any error.
  ///
  /// Verifica la firma Authenticode del archivo en [exePath].
  /// Nunca falla — devuelve unknown ante cualquier error.
  Future<ResponseRule<AuthenticodeCheckDataRule>> checkAuthenticode(
    String exePath,
  );
}