import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:path/path.dart' as p;
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Persists and resolves software using SQLite and filesystem checks.
/// Persiste y resuelve software usando SQLite y comprobaciones en disco.
class SoftwareServiceUse implements SoftwareServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;
  final FilesystemInfra _filesystem = FilesystemInfra.instance;

  SoftwareDataRule _dataRuleFromRow(SoftwareTableData row) =>
      SoftwareAdapterUse.toDataRule(SoftwareOriginUse.fromDrift(row));

  String _escapeLikePattern(String input) {
    return input.replaceAll(r'\', r'\\').replaceAll('%', r'\%').replaceAll('_', r'\_');
  }

  @override
  Future<ResponseRule<SoftwareDataRule>> create(
    String name,
    String slug, {
    String? version,
    String? description,
    int? categoryId,
    bool isAutoInstallable = true,
    bool requiresInternet = false,
    int? installerFrameworkId,
    String? extraSilentArgs,
  }) async {
    try {
      final inserted = await _database
          .into(_database.softwareTable)
          .insertReturning(
            SoftwareTableCompanion.insert(
              name: name,
              slug: slug,
              version: version != null ? Value(version) : const Value.absent(),
              description: description != null ? Value(description) : const Value.absent(),
              categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
              isAutoInstallable: Value(isAutoInstallable),
              requiresInternet: Value(requiresInternet),
              installerFrameworkId: installerFrameworkId != null
                  ? Value(installerFrameworkId)
                  : const Value.absent(),
              extraSilentArgs: extraSilentArgs != null
                  ? Value(extraSilentArgs)
                  : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _dataRuleFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> delete(int id) async {
    try {
      final existing = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final iconName = existing.iconFilename;
      await (_database.delete(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .go();
      if (iconName != null && iconName.isNotEmpty) {
        try {
          await _filesystem.deleteIcon(iconName);
        } catch (_) {
          // Icon cleanup is best-effort after DB delete.
        }
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> getByIds(List<int> ids) async {
    if (ids.isEmpty) return const SuccessResponseRule(data: []);
    try {
      final rows = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.isIn(ids))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .get();
      return SuccessResponseRule(data: rows.map(_dataRuleFromRow).toList());
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> filterByArchitecture(
    String architecture,
  ) async {
    final trimmed = architecture.trim();
    if (trimmed.isEmpty) return const SuccessResponseRule(data: []);
    try {
      final rows = await (_database.select(_database.softwareTable)
            ..where((t) => t.architecture.equals(trimmed))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .get();
      return SuccessResponseRule(data: rows.map(_dataRuleFromRow).toList());
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> getAll({
    int? categoryId,
    bool? activeOnly,
  }) async {
    try {
      final q = _database.select(_database.softwareTable);
      if (categoryId != null) q.where((t) => t.categoryId.equals(categoryId));
      if (activeOnly == true) q.where((t) => t.isActive.equals(true));
      q.orderBy([(t) => OrderingTerm.asc(t.name)]);
      final rows = await q.get();
      return SuccessResponseRule(data: rows.map(_dataRuleFromRow).toList());
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<SoftwareDataRule>> getById(int id) async {
    try {
      final row = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      return SuccessResponseRule(data: _dataRuleFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<SoftwareDataRule>> getBySlug(String slug) async {
    try {
      final row = await (_database.select(_database.softwareTable)
            ..where((t) => t.slug.equals(slug)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      return SuccessResponseRule(data: _dataRuleFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> removeInstaller(int softwareId) async {
    try {
      final existing = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      await (_database.update(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .write(SoftwareTableCompanion(
            installerId: const Value(null),
            updatedAt: Value(DateTime.now()),
          ));
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const SuccessResponseRule(data: []);
    try {
      final pattern = '%${_escapeLikePattern(trimmed)}%';
      // Fields match the canonical definition in SoftwareServiceRule.searchInMemory:
      // name, description, publisher.
      final rows = await (_database.select(_database.softwareTable)
            ..where(
              (t) =>
                  t.name.like(pattern) |
                  t.description.like(pattern) |
                  t.publisher.like(pattern),
            )
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .get();
      return SuccessResponseRule(data: rows.map(_dataRuleFromRow).toList());
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> setIcon(int softwareId, String iconFilename) async {
    try {
      final existing = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      if (!await _filesystem.iconExists(iconFilename)) {
        return const FailureResponseRule(
          message: 'Icon file not found under icons path.',
        );
      }
      await (_database.update(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .write(SoftwareTableCompanion(
            iconFilename: Value(iconFilename),
            updatedAt: Value(DateTime.now()),
          ));
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> importIconFromPath(
    int softwareId,
    String sourceFilePath,
  ) async {
    final trimmed = sourceFilePath.trim();
    if (trimmed.isEmpty) {
      return const FailureResponseRule(message: 'Icon source path is empty.');
    }
    try {
      final ext = p.extension(trimmed).toLowerCase();
      final suffix = ext.isEmpty ? '.png' : ext;
      final iconFilename = '${DateTime.now().microsecondsSinceEpoch}$suffix';
      await _filesystem.copyIcon(trimmed, iconFilename);
      return setIcon(softwareId, iconFilename);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> setInstaller(int softwareId, String installerId) async {
    try {
      final software = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (software == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final installerRow = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(installerId)))
          .getSingleOrNull();
      if (installerRow == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      if (!await _filesystem.installerFolderExists(installerId)) {
        return const FailureResponseRule(
          message: 'Installer folder missing on disk.',
        );
      }
      await (_database.update(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .write(SoftwareTableCompanion(
            installerId: Value(installerId),
            updatedAt: Value(DateTime.now()),
          ));
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> toggleActive(int softwareId, bool isActive) async {
    try {
      final existing = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      await (_database.update(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .write(SoftwareTableCompanion(
            isActive: Value(isActive),
            updatedAt: Value(DateTime.now()),
          ));
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<SoftwareDataRule>> update(
    int id, {
    String? name,
    String? version,
    String? description,
    int? categoryId,
    bool? isAutoInstallable,
    bool? requiresInternet,
    int? installerFrameworkId,
    String? extraSilentArgs,
  }) async {
    try {
      final existing = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      await (_database.update(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .write(SoftwareTableCompanion(
            name: name != null ? Value(name) : const Value.absent(),
            version: version != null ? Value(version) : const Value.absent(),
            description: description != null ? Value(description) : const Value.absent(),
            categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
            isAutoInstallable: isAutoInstallable != null
                ? Value(isAutoInstallable)
                : const Value.absent(),
            requiresInternet: requiresInternet != null
                ? Value(requiresInternet)
                : const Value.absent(),
            installerFrameworkId: installerFrameworkId != null
                ? Value(installerFrameworkId)
                : const Value.absent(),
            extraSilentArgs: extraSilentArgs != null
                ? Value(extraSilentArgs)
                : const Value.absent(),
            updatedAt: Value(DateTime.now()),
          ));
      final updated = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      return SuccessResponseRule(data: _dataRuleFromRow(updated));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  // ── Filesystem paths ────────────────────────────────────────────────────────

  @override
  String getIconPath(String iconFilename) =>
      _filesystem.getIconPath(iconFilename);

  // ── Windows Registry ────────────────────────────────────────────────────────

  @override
  Future<ResponseRule<List<InstalledSoftwareInfoRule>>> getInstalledFromRegistry({
    bool forceRefresh = false,
  }) async {
    try {
      final rawMaps = await WindowsRegistryInfra.getAll(forceRefresh: forceRefresh);
      final data = rawMaps
          .map(RegistryOriginUse.fromMap)
          .map(RegistryAdapterUse.toDataRule)
          .toList();
      return SuccessResponseRule(data: data);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstalledSoftwareInfoRule?>> findMatchInRegistry(
    String softwareName,
  ) async {
    try {
      if (softwareName.trim().isEmpty) return const SuccessResponseRule(data: null);
      final rawMaps = await WindowsRegistryInfra.getAll();
      final query     = softwareName.toLowerCase().trim();
      final queryNorm = _normRegistryName(query);
      final queryCpct = _compactRegistryName(query);

      Map<String, dynamic>? matched;

      for (final m in rawMaps) {
        final raw     = m['DisplayName'].toString();
        final key     = raw.toLowerCase();
        final keyNorm = _normRegistryName(key);
        final keyCpct = _compactRegistryName(key);

        // 1. Exact (lowercase)
        if (key == query) { matched = m; break; }
        // 2. Exact after normalisation (strips parentheticals & extra spaces)
        if (keyNorm == queryNorm) { matched = m; break; }
        // 3. Compact match (handles "notepad ++" vs "notepad++")
        if (keyCpct == queryCpct) { matched = m; break; }
        // 4. Compact contains (registry entry starts with query, e.g. "notepad++ 8.6")
        if (keyCpct.contains(queryCpct) || queryCpct.contains(keyCpct)) {
          matched = m; break;
        }
      }

      if (matched == null) return const SuccessResponseRule(data: null);
      final origin = RegistryOriginUse.fromMap(matched);
      return SuccessResponseRule(data: RegistryAdapterUse.toDataRule(origin));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  /// Normalises a registry display name for fuzzy matching:
  /// lowercase + strip parenthetical suffixes + collapse whitespace.
  static String _normRegistryName(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r'\s*\(.*?\)'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  /// Compact form: remove ALL whitespace (handles "notepad ++" vs "notepad++").
  static String _compactRegistryName(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'\s+'), '');

  @override
  void invalidateRegistryCache() => WindowsRegistryInfra.invalidateCache();

  @override
  List<SoftwareDataRule> searchInMemory(
    List<SoftwareDataRule> items,
    String query,
  ) {
    if (query.trim().isEmpty) return items;
    final lower = query.toLowerCase();
    return items.where((s) =>
      s.name.toLowerCase().contains(lower) ||
      (s.description?.toLowerCase().contains(lower) ?? false) ||
      (s.publisher?.toLowerCase().contains(lower) ?? false),
    ).toList();
  }

  @override
  InstalledSoftwareInfoRule? findBestMatchInList(
    List<InstalledSoftwareInfoRule> items,
    String softwareName,
  ) {
    if (softwareName.trim().isEmpty) return null;
    final query     = softwareName.toLowerCase().trim();
    final queryNorm = _normRegistryName(query);
    final queryCpct = _compactRegistryName(query);

    for (final item in items) {
      final key     = item.displayName.toLowerCase();
      final keyNorm = _normRegistryName(key);
      final keyCpct = _compactRegistryName(key);

      if (key == query)                                                return item;
      if (keyNorm == queryNorm)                                        return item;
      if (keyCpct == queryCpct)                                        return item;
      if (keyCpct.contains(queryCpct) || queryCpct.contains(keyCpct)) return item;
    }
    return null;
  }
}
