import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/tables_database.dart';

part 'database_infra.g.dart';

/// Database infrastructure class using Drift (SQLite).
/// Clase de infraestructura de base de datos usando Drift (SQLite).
///
/// Implements singleton pattern to avoid multiple instances.
/// Implementa patrón singleton para evitar múltiples instancias.
@DriftDatabase(
  tables: [
    CategoriesTable,
    SoftwareTable,
    InstallationPacksTable,
    PackSoftwareTable,
    InstallationsTable,
    InstallationHistoryTable,
    SoftwareDependenciesTable,
    SystemSettingsTable,
    UserPreferencesTable,
    ApplicationLogsTable,
  ],
)
class DatabaseInfra extends _$DatabaseInfra {
  DatabaseInfra._([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  /// Singleton instance.
  /// Instancia singleton.
  static DatabaseInfra? _instance;

  /// Returns the singleton instance of [DatabaseInfra].
  /// Retorna la instancia singleton de [DatabaseInfra].
  static DatabaseInfra get instance => _instance ??= DatabaseInfra._();

  /// Resets the singleton (useful for testing).
  /// Reinicia el singleton (útil para pruebas).
  static void resetInstance() {
    _instance?.close();
    _instance = null;
  }

  @override
  int get schemaVersion => 1;

  /// Database migration strategy with initial seeding.
  /// Estrategia de migración de base de datos con datos iniciales.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedDefaultCategories();
    },
  );

  /// Inserts default reference data like the No category category.
  /// Inserta datos de referencia por defecto como la categoría sin categoría.
  Future<void> _seedDefaultCategories() async {
    await into(categoriesTable).insertOnConflictUpdate(
      CategoriesTableCompanion.insert(
        name: 'No category',
        description: const Value<String?>(
          'Default category for items without an explicit category.\n'
          'Categoría por defecto para elementos sin categoría explícita.',
        ),
        icon: const Value<String?>(null),
      ),
    );
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
