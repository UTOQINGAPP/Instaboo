import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for software resolution and persistence.
/// Contrato para resolucion y persistencia de software.
abstract class SoftwareServiceRule {
  /// Creates a new software.
  Future<ResponseRule<SoftwareDataRule>> create(
    String name,
    String slug,
    {String? version, String? description, int? categoryId,
     bool isAutoInstallable = true, bool requiresInternet = false,
     int? installerFrameworkId, String? extraSilentArgs}
  );

  /// Returns a software by id.
  Future<ResponseRule<SoftwareDataRule>> getById(int id);

  /// Returns all software whose id is in [ids]. Order is not guaranteed.
  /// Useful for batch lookups across domain boundaries without N+1 queries.
  /// Devuelve todo el software cuyos ids estén en [ids]. Orden no garantizado.
  Future<ResponseRule<List<SoftwareDataRule>>> getByIds(List<int> ids);

  /// Returns all software.
  Future<ResponseRule<List<SoftwareDataRule>>> getAll({int? categoryId, bool? activeOnly});

  /// Returns a software by slug.
  Future<ResponseRule<SoftwareDataRule>> getBySlug(String slug);

  /// Updates a software.
  Future<ResponseRule<SoftwareDataRule>> update(
    int id,
    {String? name, String? version, String? description, int? categoryId,
     bool? isAutoInstallable, bool? requiresInternet,
     int? installerFrameworkId, String? extraSilentArgs}
  );

  /// Deletes a software.
  Future<ResponseRule<Unit>> delete(int id);

  /// Sets an installer for a software.
  Future<ResponseRule<Unit>> setInstaller(int softwareId, String installerId);

  /// Removes an installer from a software.
  Future<ResponseRule<Unit>> removeInstaller(int softwareId);

  /// Sets an icon for a software.
  Future<ResponseRule<Unit>> setIcon(int softwareId, String iconFilename);

  /// Copies an image from [sourceFilePath] into the managed icons folder and assigns it.
  Future<ResponseRule<Unit>> importIconFromPath(
    int softwareId,
    String sourceFilePath,
  );

  /// Toggles the active status of a software.
  Future<ResponseRule<Unit>> toggleActive(int softwareId, bool isActive);

  /// Searches for software.
  Future<ResponseRule<List<SoftwareDataRule>>> search(String query);

  /// Filters software by architecture.
  Future<ResponseRule<List<SoftwareDataRule>>> filterByArchitecture(String architecture);

  /// Finds the best-matching entry in [items] for [softwareName] using the
  /// canonical 4-step fuzzy algorithm (exact → normalised → compact → compact-contains).
  ///
  /// Synchronous: operates on an already-loaded list, no DB or IO involved.
  /// Returns null when no entry matches.
  ///
  /// Encuentra la entrada que mejor coincide con [softwareName] en [items]
  /// usando el algoritmo canónico de 4 pasos. Síncrono: opera sobre lista cargada.
  /// Filters [items] in memory using the canonical searchable fields:
  /// name, description, publisher. Returns all matching items.
  ///
  /// Synchronous: no DB or IO involved.
  /// interface/ must NOT re-implement the field selection rule.
  ///
  /// Filtra [items] en memoria con los campos canónicos buscables.
  List<SoftwareDataRule> searchInMemory(List<SoftwareDataRule> items, String query);

  InstalledSoftwareInfoRule? findBestMatchInList(
    List<InstalledSoftwareInfoRule> items,
    String softwareName,
  );

  // ── Filesystem paths ────────────────────────────────────────────────────────

  /// Returns the absolute path to [iconFilename] inside the managed icons folder.
  /// Pure path computation — synchronous and cannot fail.
  /// Devuelve la ruta absoluta al icono en la carpeta gestionada.
  String getIconPath(String iconFilename);

  // ── Windows Registry ────────────────────────────────────────────────────────

  /// Returns all programs found in the Windows uninstall registry.
  /// Pass [forceRefresh] to bypass the in-process cache.
  ///
  /// Devuelve todos los programas encontrados en el registro de Windows.
  /// Usa [forceRefresh] para ignorar la caché del proceso.
  Future<ResponseRule<List<InstalledSoftwareInfoRule>>> getInstalledFromRegistry({
    bool forceRefresh = false,
  });

  /// Returns the registry entry whose display name best matches [softwareName],
  /// wrapped in a [ResponseRule]. Returns [SuccessResponseRule] with null data
  /// when no match is found (not a failure).
  ///
  /// Devuelve la entrada del registro cuyo nombre coincide mejor con
  /// [softwareName]. Devuelve SuccessResponseRule con data null cuando no hay
  /// coincidencia (no es un fallo).
  Future<ResponseRule<InstalledSoftwareInfoRule?>> findMatchInRegistry(
    String softwareName,
  );

  /// Invalidates the registry cache so the next call re-reads from Windows.
  /// Invalida la caché del registro para que la siguiente llamada lo vuelva a leer.
  void invalidateRegistryCache();
}
