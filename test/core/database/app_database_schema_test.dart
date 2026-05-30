import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instaboo/core/infra/database/app/app_database_infra.dart';

/// Schema-level tests for [AppDatabaseInfra]: verify the fresh-create path
/// (onCreate + seeds) and that the beforeOpen seed is idempotent.
///
/// Pruebas a nivel de esquema de [AppDatabaseInfra]: verifican la creación
/// limpia (onCreate + semillas) y que la semilla de beforeOpen es idempotente.
///
/// Note: full historical v1->v4 migration testing is out of scope because no
/// per-version schema snapshots were captured at each version bump. The v4
/// baseline snapshot (drift_schemas/) enables automated testing from v5 onward.
void main() {
  late AppDatabaseInfra db;

  setUp(() {
    AppDatabaseInfra.overrideForTesting(NativeDatabase.memory());
    db = AppDatabaseInfra.instance;
  });

  tearDown(() {
    AppDatabaseInfra.resetInstance();
  });

  group('onCreate seeds a fresh database', () {
    test('seeds the default "No category"', () async {
      final categories = await db.select(db.categoriesTable).get();
      expect(categories.map((c) => c.name), contains('No category'));
    });

    test('seeds every default setting key', () async {
      final settings = await db.select(db.settingsTable).get();
      final keys = settings.map((s) => s.prefKey).toSet();
      expect(
        keys,
        containsAll(<String>[
          'parallel_installs',
          'notifications_enabled',
          'theme',
          'language',
          'auto_verify_on_startup',
          'max_log_days',
          'default_silent_args',
          'install_timeout_minutes',
        ]),
      );
    });

    test('seeds the built-in installer frameworks', () async {
      final frameworks = await db.select(db.installerFrameworksTable).get();
      final names = frameworks.map((f) => f.name).toSet();
      expect(names, contains('NSIS'));
      expect(names, contains('MSI / Windows Installer'));
      expect(frameworks.length, greaterThanOrEqualTo(8));
    });
  });

  group('beforeOpen seed is idempotent', () {
    test('re-running the default_silent_args insert keeps a single row', () async {
      Future<int> countDefaultSilentArgs() async {
        final rows = await (db.select(db.settingsTable)
              ..where((t) => t.prefKey.equals('default_silent_args')))
            .get();
        return rows.length;
      }

      expect(await countDefaultSilentArgs(), 1);

      // Same statement beforeOpen runs on every open. With `key` as the primary
      // key, INSERT OR IGNORE must not create a duplicate.
      await db.customStatement(
        "INSERT OR IGNORE INTO settings (key, value, value_type, description) "
        "VALUES ('default_silent_args', '', 'string', 'Default silent args.');",
      );

      expect(await countDefaultSilentArgs(), 1);
    });
  });
}
