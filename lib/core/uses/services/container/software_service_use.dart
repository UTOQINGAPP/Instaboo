import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Software service implementation. Persists and retrieves software via Drift.
/// Uses [DatabaseInfra.softwareTable] and [SoftwareAdapterUse] for mapping.
///
/// Requires: run `flutter pub run build_runner build --delete-conflicting-outputs`
/// so that [DatabaseInfra.softwareTable], [SoftwareTableData] and
/// [SoftwareTableCompanion] are generated in database_infra.g.dart.
///
/// Implementación del servicio de software. Persiste y obtiene software vía Drift.
/// Usa [DatabaseInfra.softwareTable] y [SoftwareAdapterUse] para el mapeo.
/// Requiere: ejecutar build_runner para generar softwareTable y tipos en .g.dart.
class SoftwareServiceUse implements SoftwareServiceRule {
  final DatabaseInfra _db = DatabaseInfra.instance;

  SoftwareServiceUse();

  @override
  Future<ApiResponseRule<Unit>> createSoftware({
    required String name,
    required String slug,
    String? version,
    required int categoryId,
    String? description,
    String? logo,
    int? sizeMb,
    required InstallationTypeEnumRule installationType,
    required InstallerSourceTypeEnumRule installerSourceType,
    required String installerSource,
    String? silentArgs,
  }) async {
    try {
      await _db
          .into(_db.softwareTable)
          .insert(
            SoftwareTableCompanion.insert(
              name: name,
              slug: slug,
              version: Value(version),
              categoryId: categoryId,
              description: Value(description),
              logo: Value(logo),
              sizeMb: Value(sizeMb),
              installationType: Value(
                InstallationTypeEnumDatabase.values.byName(
                  installationType.name,
                ),
              ),
              installerSourceType: Value(
                InstallerSourceTypeEnumDatabase.values.byName(
                  installerSourceType.name,
                ),
              ),
              installerSource: installerSource,
              silentArgs: Value(silentArgs),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CREATE_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updateSoftware({
    required int softwareId,
    String? name,
    String? version,
    String? description,
    String? logo,
    bool? isActive,
  }) async {
    try {
      await (_db.update(
        _db.softwareTable,
      )..where((t) => t.id.equals(softwareId))).write(
        SoftwareTableCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          version: version != null ? Value(version) : const Value.absent(),
          description: description != null
              ? Value(description)
              : const Value.absent(),
          logo: logo != null ? Value(logo) : const Value.absent(),
          isActive: isActive != null ? Value(isActive) : const Value.absent(),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deleteSoftware(int softwareId) async {
    try {
      await (_db.delete(
        _db.softwareTable,
      )..where((t) => t.id.equals(softwareId))).go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_SOFTWARE',
      );
    }
  }

  /// Converts a software row to [SoftwareDataRule] using only origin (no category resolution).
  /// Convierte una fila de software a [SoftwareDataRule] usando solo el origin (sin resolución de categoría).
  Future<ApiResponseRule<SoftwareDataRule>> _rowToSoftwareData(
    SoftwareTableData row,
  ) async {
    final origin = SoftwareDriftOriginUse.fromTableData(row);
    return SuccessResponseRule<SoftwareDataRule>(
      data: SoftwareAdapterUse.fromOrigin(origin),
    );
  }

  @override
  Future<ApiResponseRule<SoftwareDataRule>> getSoftwareById(
    int softwareId,
  ) async {
    try {
      final query = _db.select(_db.softwareTable)
        ..where((t) => t.id.equals(softwareId))
        ..limit(1);
      final rows = await query.get();
      if (rows.isEmpty) {
        return const FailureResponseRule(
          message: 'Software not found',
          errorCode: 'NOT_FOUND',
        );
      }
      return _rowToSoftwareData(rows.single);
    } catch (e) {
      return FailureResponseRule<SoftwareDataRule>(
        message: e.toString(),
        errorCode: 'GET_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> listSoftware() async {
    try {
      final rows = await (_db.select(
        _db.softwareTable,
      )..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
      final list = <SoftwareDataRule>[];
      for (final row in rows) {
        final result = await _rowToSoftwareData(row);
        if (result.isFailure) {
          final f = result as FailureResponseRule<SoftwareDataRule>;
          return FailureResponseRule<List<SoftwareDataRule>>(
            message: f.message,
            errorCode: f.errorCode,
          );
        }
        list.add((result as SuccessResponseRule<SoftwareDataRule>).data);
      }
      return SuccessResponseRule<List<SoftwareDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<SoftwareDataRule>>(
        message: e.toString(),
        errorCode: 'LIST_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> searchSoftware(
    String query,
  ) async {
    try {
      final pattern = '%${query.trim()}%';
      final rows =
          await (_db.select(_db.softwareTable)
                ..where(
                  (t) =>
                      t.name.like(pattern) |
                      t.slug.like(pattern) |
                      t.description.like(pattern),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.name)]))
              .get();
      final list = <SoftwareDataRule>[];
      for (final row in rows) {
        final result = await _rowToSoftwareData(row);
        if (result.isFailure) {
          final f = result as FailureResponseRule<SoftwareDataRule>;
          return FailureResponseRule<List<SoftwareDataRule>>(
            message: f.message,
            errorCode: f.errorCode,
          );
        }
        list.add((result as SuccessResponseRule<SoftwareDataRule>).data);
      }
      return SuccessResponseRule<List<SoftwareDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<SoftwareDataRule>>(
        message: e.toString(),
        errorCode: 'SEARCH_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> addDependency({
    required int softwareId,
    required int dependencySoftwareId,
    bool isRequired = true,
  }) async {
    try {
      await _db
          .into(_db.softwareDependenciesTable)
          .insert(
            SoftwareDependenciesTableCompanion.insert(
              softwareId: softwareId,
              dependencySoftwareId: dependencySoftwareId,
              isRequired: Value(isRequired),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'ADD_DEPENDENCY',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> removeDependency({
    required int softwareId,
    required int dependencySoftwareId,
  }) async {
    try {
      await (_db.delete(_db.softwareDependenciesTable)..where(
            (t) =>
                t.softwareId.equals(softwareId) &
                t.dependencySoftwareId.equals(dependencySoftwareId),
          ))
          .go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'REMOVE_DEPENDENCY',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId,
  ) async {
    try {
      final depRows = await (_db.select(
        _db.softwareDependenciesTable,
      )..where((t) => t.softwareId.equals(softwareId))).get();
      if (depRows.isEmpty) {
        return SuccessResponseRule(data: <SoftwareDataRule>[]);
      }
      final depIds = depRows.map((r) => r.dependencySoftwareId).toList();
      final softwareRows = await (_db.select(
        _db.softwareTable,
      )..where((t) => t.id.isIn(depIds))).get();
      final list = <SoftwareDataRule>[];
      for (final row in softwareRows) {
        final result = await _rowToSoftwareData(row);
        if (result.isFailure) {
          final f = result as FailureResponseRule<SoftwareDataRule>;
          return FailureResponseRule<List<SoftwareDataRule>>(
            message: f.message,
            errorCode: f.errorCode,
          );
        }
        list.add((result as SuccessResponseRule<SoftwareDataRule>).data);
      }
      return SuccessResponseRule<List<SoftwareDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<SoftwareDataRule>>(
        message: e.toString(),
        errorCode: 'GET_DEPENDENCIES',
      );
    }
  }
}
