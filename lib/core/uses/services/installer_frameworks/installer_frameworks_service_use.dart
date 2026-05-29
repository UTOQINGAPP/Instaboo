import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Installer framework persistence in SQLite.
/// Persistencia de frameworks de instalador en SQLite.
class InstallerFrameworksServiceUse implements InstallerFrameworksServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  InstallerFrameworkDataRule _fromRow(InstallerFrameworksTableData row) =>
      InstallerFrameworkAdapterUse.toDataRule(
        InstallerFrameworkOriginUse.fromDrift(row),
      );

  @override
  Future<ResponseRule<List<InstallerFrameworkDataRule>>> getAll() async {
    try {
      final rows = await (_database.select(_database.installerFrameworksTable)
            ..orderBy([
              (t) => OrderingTerm.asc(t.sortOrder),
              (t) => OrderingTerm.asc(t.name),
            ]))
          .get();
      return SuccessResponseRule(data: rows.map(_fromRow).toList());
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerFrameworkDataRule>> getById(int id) async {
    try {
      final row = await (_database.select(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Installer framework not found.');
      }
      return SuccessResponseRule(data: _fromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerFrameworkDataRule>> getByName(String name) async {
    try {
      final lower = name.toLowerCase();
      final all = await _database.select(_database.installerFrameworksTable).get();
      final row = all.where((r) => r.name.toLowerCase() == lower).firstOrNull;
      if (row == null) {
        return const FailureResponseRule(message: 'Installer framework not found.');
      }
      return SuccessResponseRule(data: _fromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerFrameworkDataRule>> create({
    required String name,
    String? description,
    String silentArgs = '',
  }) async {
    try {
      final row = await _database
          .into(_database.installerFrameworksTable)
          .insertReturning(
            InstallerFrameworksTableCompanion.insert(
              name: name,
              description: description != null ? Value(description) : const Value.absent(),
              silentArgs: Value(silentArgs),
              isBuiltIn: const Value(false),
            ),
          );
      return SuccessResponseRule(data: _fromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<InstallerFrameworkDataRule>> update(
    int id, {
    String? name,
    String? description,
    String? silentArgs,
  }) async {
    try {
      final existing = await (_database.select(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Installer framework not found.');
      }
      await (_database.update(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .write(
        InstallerFrameworksTableCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          description: description != null ? Value(description) : const Value.absent(),
          silentArgs: silentArgs != null ? Value(silentArgs) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      final updated = await (_database.select(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      return SuccessResponseRule(data: _fromRow(updated));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> delete(int id) async {
    try {
      final row = await (_database.select(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Installer framework not found.');
      }
      if (row.isBuiltIn) {
        return const FailureResponseRule(
          message: 'Built-in installer framework types cannot be deleted.',
        );
      }
      await (_database.delete(_database.installerFrameworksTable)
            ..where((t) => t.id.equals(id)))
          .go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }
}
