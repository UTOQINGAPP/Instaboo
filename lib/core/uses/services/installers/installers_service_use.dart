import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:path/path.dart' as p;
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';


/// Persists installers in SQLite and syncs with the installers filesystem tree.
/// Persiste instaladores en SQLite y sincroniza con el árbol de instaladores en disco.
class InstallersServiceUse implements InstallersServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;
  final FilesystemInfra _filesystem = FilesystemInfra.instance;

  InstallerDataRule _dataRuleFromRow(InstallersTableData row) =>
      InstallerAdapterUse.toDataRule(InstallerOriginUse.fromDrift(row));

  @override
  Future<ResponseRule<InstallerDataRule>> create(
    String id,
    String contentType,
    String mainExecutable, {
    String? installerType,
    String? silentArgs,
    String? originalName,
  }) async {
    if (id.length > 20) {
      return const FailureResponseRule(
        message: 'Installer id exceeds 20 characters.',
      );
    }
    try {
      final inserted = await _database
          .into(_database.installersTable)
          .insertReturning(
            InstallersTableCompanion.insert(
              id: id,
              contentType: contentType,
              mainExecutable: mainExecutable,
              installerType: installerType != null
                  ? Value(installerType)
                  : const Value.absent(),
              silentArgs: silentArgs != null
                  ? Value(silentArgs)
                  : const Value.absent(),
              originalName: originalName != null
                  ? Value(originalName)
                  : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _dataRuleFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> delete(String id) async {
    try {
      final existing = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      await (_database.delete(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .go();
      try {
        await _filesystem.deleteInstallerFolder(id);
      } catch (e) {
        return FailureResponseRule(message: e.toString());
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<InstallerDataRule>>> getAll() async {
    try {
      final rows = await (_database.select(_database.installersTable)
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
      return SuccessResponseRule(
        data: rows.map(_dataRuleFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerDataRule>> getById(String id) async {
    try {
      final row = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      return SuccessResponseRule(data: _dataRuleFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerDataRule>> getMainExecutablePath(String id) async {
    try {
      final row = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      if (!await _filesystem.installerExecutableExists(id, row.mainExecutable)) {
        return const FailureResponseRule(
          message: 'Main executable not found on disk.',
        );
      }
      return SuccessResponseRule(data: _dataRuleFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<InstallerDataRule>>> getUnused() async {
    try {
      final installers = await _database.select(_database.installersTable).get();
      final softwareRows = await _database.select(_database.softwareTable).get();
      final usedIds = softwareRows
          .map((s) => s.installerId)
          .whereType<String>()
          .toSet();
      final unused = installers
          .where((i) => !usedIds.contains(i.id))
          .toList()
        ..sort((a, b) => a.id.compareTo(b.id));
      return SuccessResponseRule(
        data: unused.map(_dataRuleFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> updateMetadata(
    String id, {
    int? fileCount,
    int? totalSizeBytes,
    String? fileHashSha256,
  }) async {
    try {
      final existing = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      await (_database.update(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .write(
        InstallersTableCompanion(
          fileCount:
              fileCount != null ? Value(fileCount) : const Value.absent(),
          totalSizeBytes: totalSizeBytes != null
              ? Value(totalSizeBytes)
              : const Value.absent(),
          fileHashSha256: fileHashSha256 != null
              ? Value(fileHashSha256)
              : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> verify(String id) async {
    try {
      final row = await (_database.select(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Installer not found.');
      }
      final exeOk =
          await _filesystem.installerExecutableExists(id, row.mainExecutable);
      int? fileCount;
      int? totalSizeBytes;
      if (await _filesystem.installerFolderExists(id)) {
        try {
          final info = await _filesystem.getInstallerFolderInfo(id);
          fileCount = info['fileCount'] as int?;
          totalSizeBytes = info['totalSizeBytes'] as int?;
        } catch (_) {}
      }
      await (_database.update(_database.installersTable)
            ..where((t) => t.id.equals(id)))
          .write(
        InstallersTableCompanion(
          isVerified: Value(exeOk),
          lastVerifiedAt: Value(DateTime.now()),
          fileCount: fileCount != null ? Value(fileCount) : const Value.absent(),
          totalSizeBytes: totalSizeBytes != null
              ? Value(totalSizeBytes)
              : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  static String? _truncateSilentArgs(String? args) {
    if (args == null) return null;
    final t = args.trim();
    if (t.isEmpty) return null;
    if (t.length <= 500) return t;
    return t.substring(0, 500);
  }

  @override
  Future<ResponseRule<InstallerDataRule>> importSingleFileFromPath(
    String sourceFilePath, {
    String? silentArgs,
  }) async {
    final trimmed = sourceFilePath.trim();
    if (trimmed.isEmpty) {
      return const FailureResponseRule(
        message: 'Installer source path is empty.',
      );
    }
    final mainExecutable = p.basename(trimmed);
    final id = 'i${DateTime.now().millisecondsSinceEpoch}';
    if (id.length > 20) {
      return const FailureResponseRule(message: 'Installer id too long.');
    }
    final ext = p.extension(mainExecutable).toLowerCase();
    final String installerType = switch (ext) {
      '.exe' => 'exe',
      '.msi' => 'msi',
      '.msix' => 'msix',
      _ => 'other',
    };
    final silent = _truncateSilentArgs(silentArgs);
    try {
      await _filesystem.copyFileToInstaller(id, trimmed, mainExecutable);
      final hash =
          await _filesystem.calculateExecutableHash(id, mainExecutable);
      var fileCount = 1;
      int? totalSizeBytes;
      try {
        final info = await _filesystem.getInstallerFolderInfo(id);
        fileCount = info['fileCount'] as int? ?? 1;
        totalSizeBytes = info['totalSizeBytes'] as int?;
      } catch (_) {}
      final inserted = await _database
          .into(_database.installersTable)
          .insertReturning(
            InstallersTableCompanion.insert(
              id: id,
              contentType: 'single_file',
              mainExecutable: mainExecutable,
              installerType: Value(installerType),
              silentArgs:
                  silent != null ? Value(silent) : const Value.absent(),
              originalName: Value(mainExecutable),
              fileCount: Value(fileCount),
              totalSizeBytes: totalSizeBytes != null
                  ? Value(totalSizeBytes)
                  : const Value.absent(),
              fileHashSha256: Value(hash),
            ),
          );
      return SuccessResponseRule(data: _dataRuleFromRow(inserted));
    } catch (e) {
      try {
        await _filesystem.deleteInstallerFolder(id);
      } catch (_) {}
      return FailureResponseRule(message: e.toString());
    }
  }
}
