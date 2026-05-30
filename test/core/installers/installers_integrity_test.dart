import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instaboo/core/infra/database/app/app_database_infra.dart';
import 'package:instaboo/core/infra/filesystem/filesystem_infra.dart';
import 'package:instaboo/core/uses/services/installers/installers_service_use.dart';
import 'package:path/path.dart' as p;

/// Integrity-verification tests for SEC-02. Uses an in-memory database and a
/// temporary installers tree so the SHA-256 is computed against real files.
///
/// Pruebas de verificación de integridad (SEC-02). Usan BD en memoria y un
/// árbol de instaladores temporal para calcular el SHA-256 sobre archivos reales.
void main() {
  late Directory tempDir;
  late String installersBase;
  late InstallersServiceUse service;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('instaboo_sec02');
    installersBase = p.join(tempDir.path, 'installers');

    AppDatabaseInfra.overrideForTesting(NativeDatabase.memory());
    FilesystemInfra.resetForTesting();
    FilesystemInfra.initialize(
      installersBasePath: installersBase,
      iconsBasePath: p.join(tempDir.path, 'icons'),
      logsBasePath: p.join(tempDir.path, 'logs'),
    );

    service = InstallersServiceUse();
  });

  tearDown(() {
    AppDatabaseInfra.resetInstance();
    FilesystemInfra.resetForTesting();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  /// Writes a fake executable on disk at installers/<id>/<exe>.
  Future<void> writeExecutable(String id, String exe, List<int> bytes) async {
    final dir = Directory(p.join(installersBase, id));
    await dir.create(recursive: true);
    await File(p.join(dir.path, exe)).writeAsBytes(bytes);
  }

  test('passes when the on-disk hash matches the stored baseline', () async {
    await writeExecutable('itest1', 'setup.exe', [1, 2, 3, 4, 5]);
    await service.create('itest1', 'single_file', 'setup.exe');
    final hash =
        await FilesystemInfra.instance.calculateExecutableHash('itest1', 'setup.exe');
    await service.updateMetadata('itest1', fileHashSha256: hash);

    final result = await service.checkIntegrity('itest1');
    expect(result.isSuccess, isTrue);
  });

  test('fails when the executable was tampered with after import', () async {
    await writeExecutable('itest2', 'setup.exe', [1, 2, 3, 4, 5]);
    await service.create('itest2', 'single_file', 'setup.exe');
    final hash =
        await FilesystemInfra.instance.calculateExecutableHash('itest2', 'setup.exe');
    await service.updateMetadata('itest2', fileHashSha256: hash);

    // Tamper with the binary on disk.
    await File(p.join(installersBase, 'itest2', 'setup.exe'))
        .writeAsBytes([9, 9, 9, 9, 9, 9]);

    final result = await service.checkIntegrity('itest2');
    expect(result.isFailure, isTrue);
  });

  test('trust-on-first-use: adopts and stores the hash when none exists',
      () async {
    await writeExecutable('itest3', 'setup.exe', [7, 7, 7]);
    await service.create('itest3', 'single_file', 'setup.exe'); // no stored hash

    final result = await service.checkIntegrity('itest3');
    expect(result.isSuccess, isTrue);

    final stored = (await service.getById('itest3')).resolve(
      onSuccess: (data, _) => data.fileHashSha256,
      onFailure: (_, _) => null,
    );
    expect(stored, isNotNull);
    expect(stored, isNotEmpty);
  });

  test('fails when the executable is missing on disk', () async {
    await service.create('itest4', 'single_file', 'setup.exe'); // no file written

    final result = await service.checkIntegrity('itest4');
    expect(result.isFailure, isTrue);
  });
}
