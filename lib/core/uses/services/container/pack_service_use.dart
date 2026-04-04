import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Pack service use implementation. Delegates to infra (DatabaseInfra).
/// Uses [DatabaseInfra.installationPacksTable] and [PackAdapterUse] for mapping.
///
/// Implementación del use de servicio de packs. Delega en infra (DatabaseInfra).
/// Usa [DatabaseInfra.installationPacksTable] y [PackAdapterUse] para el mapeo.
class PackServiceUse implements PackServiceRule {
  /// Database infrastructure instance.
  /// Instancia de infraestructura de base de datos.
  final DatabaseInfra _db = DatabaseInfra.instance;

  /// Creates the use with optional database instance (for testing).
  /// Crea el use con instancia de base de datos opcional (para pruebas).
  PackServiceUse();

  @override
  Future<ApiResponseRule<Unit>> createPack({
    required String name,
    String? description,
  }) async {
    try {
      await _db
          .into(_db.installationPacksTable)
          .insert(
            InstallationPacksTableCompanion.insert(
              name: name,
              description: Value(description),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CREATE_PACK',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updatePack({
    required int packId,
    String? name,
    String? description,
    bool? isActive,
  }) async {
    try {
      final companion = InstallationPacksTableCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        description: description != null
            ? Value(description)
            : const Value.absent(),
        isActive: isActive != null ? Value(isActive) : const Value.absent(),
        updatedAt: Value(DateTime.now().toUtc()),
      );
      await (_db.update(
        _db.installationPacksTable,
      )..where((t) => t.id.equals(packId))).write(companion);
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_PACK',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deletePack(int packId) async {
    try {
      await (_db.delete(
        _db.installationPacksTable,
      )..where((t) => t.id.equals(packId))).go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_PACK',
      );
    }
  }

  @override
  Future<ApiResponseRule<InstallationPacksDataRule>> getPackById(
    int packId,
  ) async {
    try {
      final row = await (_db.select(
        _db.installationPacksTable,
      )..where((t) => t.id.equals(packId))).getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(
          message: 'Pack not found',
          errorCode: 'NOT_FOUND',
        );
      }
      final data = PackAdapterUse.fromOrigin(
        PackDriftOriginUse.fromTableData(row),
      );
      return SuccessResponseRule(data: data);
    } catch (e) {
      return FailureResponseRule(message: e.toString(), errorCode: 'GET_PACK');
    }
  }

  @override
  Future<ApiResponseRule<List<InstallationPacksDataRule>>> listPacks() async {
    try {
      final rows = await _db.select(_db.installationPacksTable).get();
      final list = rows
          .map(
            (row) => PackAdapterUse.fromOrigin(
              PackDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'LIST_PACKS',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<SoftwareDataRule>>> getPackSoftware(
    int packId,
  ) async {
    try {
      final linkRows = await (_db.select(
        _db.packSoftwareTable,
      )..where((t) => t.packId.equals(packId))).get();
      if (linkRows.isEmpty) {
        return SuccessResponseRule(data: <SoftwareDataRule>[]);
      }
      final softwareIds = linkRows.map((r) => r.softwareId).toList();
      final softwareRows = await (_db.select(
        _db.softwareTable,
      )..where((t) => t.id.isIn(softwareIds))).get();
      final list = <SoftwareDataRule>[];
      for (final row in softwareRows) {
        final origin = SoftwareDriftOriginUse.fromTableData(row);

        list.add(SoftwareAdapterUse.fromOrigin(origin));
      }
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_PACK_SOFTWARE',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> addSoftwareToPack({
    required int packId,
    required int softwareId,
    int sortOrder = 0,
  }) async {
    try {
      await _db
          .into(_db.packSoftwareTable)
          .insert(
            PackSoftwareTableCompanion.insert(
              packId: packId,
              softwareId: softwareId,
              sortOrder: Value(sortOrder),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'ADD_SOFTWARE_TO_PACK',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> removeSoftwareFromPack({
    required int packId,
    required int softwareId,
  }) async {
    try {
      await (_db.delete(_db.packSoftwareTable)..where(
            (t) => t.packId.equals(packId) & t.softwareId.equals(softwareId),
          ))
          .go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'REMOVE_SOFTWARE_FROM_PACK',
      );
    }
  }
}
