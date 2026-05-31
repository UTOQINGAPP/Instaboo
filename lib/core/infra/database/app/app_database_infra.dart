import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../tables/tables_database.dart';

part 'app_database_infra.g.dart';

/// Database infrastructure using Drift (SQLite).
/// Infraestructura de base de datos con Drift (SQLite).
///
/// Singleton to avoid multiple open connections.
/// Singleton para evitar múltiples conexiones abiertas.
@DriftDatabase(
  tables: [
    CategoriesTable,
    InstallerFrameworksTable,
    InstallersTable,
    SoftwareTable,
    SoftwareDependenciesTable,
    InstallationPacksTable,
    PackItemsTable,
    InstallationQueueTable,
    InstallationHistoryTable,
    SettingsTable,
    LogsTable,
  ],
)
class AppDatabaseInfra extends _$AppDatabaseInfra {
  AppDatabaseInfra._([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  /// Singleton instance.
  /// Instancia singleton.
  static AppDatabaseInfra? _instance;

  /// Returns the shared [AppDatabaseInfra] instance.
  /// Retorna la instancia compartida de [AppDatabaseInfra].
  static AppDatabaseInfra get instance => _instance ??= AppDatabaseInfra._();

  /// Closes and clears the singleton (e.g. tests).
  /// Cierra y limpia el singleton (p. ej. pruebas).
  static void resetInstance() {
    _instance?.close();
    _instance = null;
  }

  /// Test-only seam: replaces the singleton with one backed by [executor]
  /// (e.g. `NativeDatabase.memory()`). The database stays inside core/infra —
  /// production wiring is untouched, services keep reading [instance].
  ///
  /// Costura solo para pruebas: reemplaza el singleton por uno respaldado por
  /// [executor] (p. ej. `NativeDatabase.memory()`). La BD permanece dentro de
  /// core/infra; el cableado de producción no cambia y los services siguen
  /// leyendo [instance].
  static void overrideForTesting(QueryExecutor executor) {
    _instance?.close();
    _instance = AppDatabaseInfra._(executor);
  }

  @override
  int get schemaVersion => 4;

  /// Creates schema on first open and applies recommended pragmas.
  /// Crea el esquema en el primer abrir y aplica pragmas recomendados.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedDefaultCategories();
          await _seedDefaultSettings();
          await _seedDefaultInstallerFrameworks();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // v2: add requires_internet column to software table.
            // v2: agrega columna requires_internet a la tabla software.
            await customStatement(
              'ALTER TABLE software ADD COLUMN requires_internet INTEGER NOT NULL DEFAULT 0;',
            );
            // v2: seed default_silent_args setting for existing installations.
            // v2: sembrar default_silent_args para instalaciones existentes.
            await customStatement(
              "INSERT OR IGNORE INTO settings (key, value, value_type, description)"
              " VALUES ('default_silent_args', '', 'string',"
              " 'Default silent install arguments applied to all software when no specific args are set.');",
            );
          }
          if (from < 3) {
            // v3: create installer_frameworks table.
            // v3: crea la tabla installer_frameworks.
            await m.createTable(installerFrameworksTable);
            // v3: add installer_framework_id column to software.
            // v3: agrega columna installer_framework_id a software.
            await customStatement(
              'ALTER TABLE software ADD COLUMN installer_framework_id INTEGER REFERENCES installer_frameworks(id) ON DELETE SET NULL;',
            );
            // v3: add extra_silent_args column to software.
            // v3: agrega columna extra_silent_args a software.
            await customStatement(
              'ALTER TABLE software ADD COLUMN extra_silent_args TEXT;',
            );
            // v3: seed built-in installer framework types.
            // v3: sembrar tipos de framework integrados.
            await _seedDefaultInstallerFrameworks();
          }
          if (from < 4) {
            // v4: add machine_info JSON column to installation_history.
            // v4: agrega columna machine_info JSON a installation_history.
            await customStatement(
              'ALTER TABLE installation_history ADD COLUMN machine_info TEXT;',
            );
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
          await customStatement('PRAGMA journal_mode = WAL;');
          await customStatement('PRAGMA busy_timeout = 5000;');
          await customStatement('PRAGMA synchronous = NORMAL;');
          // Ensure settings introduced after v1 exist in any installation.
          // Garantiza que los settings añadidos después de v1 existen en cualquier instalación.
          await customStatement(
            "INSERT OR IGNORE INTO settings (key, value, value_type, description)"
            " VALUES ('default_silent_args', '', 'string',"
            " 'Default silent install arguments applied to all software when no specific args are set.');",
          );
          await customStatement(
            "INSERT OR IGNORE INTO settings (key, value, value_type, description)"
            " VALUES ('install_timeout_minutes', '15', 'integer',"
            " 'Per-installer timeout in minutes; 0 disables it.');",
          );
          await customStatement(
            "INSERT OR IGNORE INTO settings (key, value, value_type, description)"
            " VALUES ('verify_authenticode', '1', 'boolean',"
            " 'Verify Authenticode signature before running an installer. Disable to allow unsigned binaries. / Verificar firma Authenticode antes de ejecutar un instalador. Desactivar para permitir binarios sin firmar.');",
          );
          // Remove the obsolete run_as_admin setting: the app always runs
          // elevated via the manifest, so this flag is dead.
          // Elimina el setting obsoleto run_as_admin: la app siempre corre
          // elevada vía el manifiesto, así que esta bandera es código muerto.
          await customStatement(
            "DELETE FROM settings WHERE key = 'run_as_admin';",
          );
        },
      );

  /// Default category for uncategorized software.
  /// Categoría por defecto para software sin categoría.
  Future<void> _seedDefaultCategories() async {
    await into(categoriesTable).insert(
      CategoriesTableCompanion.insert(
        name: 'No category',
        description: const Value<String?>(
          'Default category for items without an explicit category.\n'
          'Categoría por defecto para elementos sin categoría explícita.',
        ),
        icon: const Value<String?>(null),
        sortOrder: const Value(0),
        parentId: const Value<int?>(null),
      ),
    );
  }

  /// Initial rows for [settings] (migration v1 seed).
  /// Filas iniciales de [settings] (semilla de migración v1).
  Future<void> _seedDefaultSettings() async {
    await batch((b) {
      b.insertAll(
        settingsTable,
        [
          SettingsTableCompanion.insert(
            prefKey: 'parallel_installs',
            prefValue: const Value('2'),
            valueType: const Value('integer'),
            description: const Value(
              'Allowed concurrent installs. / Instalaciones simultaneas permitidas.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'notifications_enabled',
            prefValue: const Value('1'),
            valueType: const Value('boolean'),
            description: const Value(
              'System notifications. / Mostrar notificaciones del sistema.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'theme',
            prefValue: const Value('system'),
            valueType: const Value('string'),
            description: const Value(
              'UI theme: system, light, dark. / Tema visual: system, light, dark.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'language',
            prefValue: const Value('es'),
            valueType: const Value('string'),
            description: const Value(
              'Interface language. / Idioma de la interfaz.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'auto_verify_on_startup',
            prefValue: const Value('1'),
            valueType: const Value('boolean'),
            description: const Value(
              'Verify installers on startup. / Verificar instaladores al iniciar.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'max_log_days',
            prefValue: const Value('30'),
            valueType: const Value('integer'),
            description: const Value(
              'Log retention in days. / Dias de retencion de logs.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'default_silent_args',
            prefValue: const Value(''),
            valueType: const Value('string'),
            description: const Value(
              'Default silent install arguments applied to all software when no specific args are set. / Argumentos silenciosos por defecto aplicados a todo el software cuando no se especifican args propios.',
            ),
          ),
          SettingsTableCompanion.insert(
            prefKey: 'install_timeout_minutes',
            prefValue: const Value('15'),
            valueType: const Value('integer'),
            description: const Value(
              'Per-installer timeout in minutes; 0 disables it. / Timeout por instalador en minutos; 0 lo desactiva.',
            ),
          ),
        ],
      );
    });
  }

  /// Built-in installer framework types with their default silent args.
  /// Tipos de framework integrados con sus argumentos silenciosos por defecto.
  Future<void> _seedDefaultInstallerFrameworks() async {
    const frameworks = [
      (
        name: 'NSIS',
        description: 'Nullsoft Scriptable Install System',
        args: '/S',
        sort: 0,
      ),
      (
        name: 'Inno Setup',
        description: 'Jordan Russell\'s Inno Setup',
        args: '/VERYSILENT /SUPPRESSMSGBOXES /SP- /NORESTART',
        sort: 1,
      ),
      (
        name: 'MSI / Windows Installer',
        description: 'Microsoft Windows Installer (.msi)',
        args: '/quiet /norestart REBOOT=ReallySuppress',
        sort: 2,
      ),
      (
        name: 'InstallShield',
        description: 'Flexera InstallShield',
        args: '/s /v"/qn REBOOT=ReallySuppress"',
        sort: 3,
      ),
      (
        name: 'Squirrel',
        description: 'Squirrel (Electron apps: Discord, Slack, etc.)',
        args: '--silent',
        sort: 4,
      ),
      (
        name: 'Qt Installer Framework',
        description: 'Qt IFW - Qt and some cross-platform apps',
        args: '--silent --accept-licenses --default-answer --confirm-command',
        sort: 5,
      ),
      (
        name: '7-Zip SFX / WinRAR SFX',
        description: 'Self-extracting archives (7-Zip or WinRAR)',
        args: '-y',
        sort: 6,
      ),
      (
        name: 'Generic / Other',
        description: 'Fallback for unknown or custom installers',
        args: '/S',
        sort: 7,
      ),
    ];

    for (final f in frameworks) {
      await into(installerFrameworksTable).insertOnConflictUpdate(
        InstallerFrameworksTableCompanion.insert(
          name: f.name,
          description: Value(f.description),
          silentArgs: Value(f.args),
          isBuiltIn: const Value(true),
          sortOrder: Value(f.sort),
        ),
      );
    }
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final exeDir = Directory(File(Platform.resolvedExecutable).parent.path);
      final dbFile = File(p.join(exeDir.path, 'instaboo.db'));

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(dbFile);
    });
  }
}
