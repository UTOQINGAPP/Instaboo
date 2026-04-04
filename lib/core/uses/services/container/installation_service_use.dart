import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Installation service use implementation. Delegates to infra (DatabaseInfra).
/// Uses [DatabaseInfra.installationsTable] and [InstallationAdapterUse] for mapping.
///
/// Implementación del use de servicio de instalaciones. Delega en infra (DatabaseInfra).
/// Usa [DatabaseInfra.installationsTable] y [InstallationAdapterUse] para el mapeo.
class InstallationServiceUse implements InstallationServiceRule {
  /// Database infrastructure instance.
  /// Instancia de infraestructura de base de datos.
  final DatabaseInfra _db = DatabaseInfra.instance;

  /// Creates the use with optional database instance (for testing).
  /// Crea el use con instancia de base de datos opcional (para pruebas).
  InstallationServiceUse();

  @override
  Future<ApiResponseRule<List<InstallationsDataRule>>>
  createManualInstallations(List<int> softwareIds) async {
    if (softwareIds.isEmpty) {
      return SuccessResponseRule(data: <InstallationsDataRule>[]);
    }
    try {
      final createdIds = <int>[];
      for (final softwareId in softwareIds) {
        final id = await _db.into(_db.installationsTable).insert(
              InstallationsTableCompanion.insert(
                sourceType:
                    InstallationSourceTypeEnumDatabase.values.byName(
                      InstallationSourceTypeEnumRule.software.name,
                    ),
                softwareId: Value(softwareId),
                displayName: 'Software #$softwareId',
                status: Value(
                  InstallationStatusEnumDatabase.values.byName(
                    InstallationStatusEnumRule.pending.name,
                  ),
                ),
                progress: const Value(0),
              ),
            );
        createdIds.add(id);
      }
      final rows = await (_db.select(_db.installationsTable)
            ..where((t) => t.id.isIn(createdIds)))
          .get();
      final created = rows
          .map(
            (row) => InstallationAdapterUse.fromOrigin(
              InstallationDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: created);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'CREATE_MANUAL_INSTALLATIONS',
      );
    }
  }

  @override
  Future<ApiResponseRule<InstallationsDataRule>> createPackInstallation(
    int packId,
  ) async {
    try {
      final pack = await (_db.select(
        _db.installationPacksTable,
      )..where((t) => t.id.equals(packId))).getSingleOrNull();
      if (pack == null) {
        return const FailureResponseRule(
          message: 'Pack not found',
          errorCode: 'PACK_NOT_FOUND',
        );
      }
      final id = await _db.into(_db.installationsTable).insert(
            InstallationsTableCompanion.insert(
              sourceType:
                  InstallationSourceTypeEnumDatabase.values.byName(
                    InstallationSourceTypeEnumRule.pack.name,
                  ),
              packId: Value(packId),
              displayName: pack.name,
              status: Value(
                InstallationStatusEnumDatabase.values.byName(
                  InstallationStatusEnumRule.pending.name,
                ),
              ),
              progress: const Value(0),
            ),
          );
      final rows = await (_db.select(_db.installationsTable)
            ..where((t) => t.id.equals(id))
            ..limit(1))
          .get();
      if (rows.isEmpty) {
        return const FailureResponseRule(
          message: 'Failed to read created installation',
          errorCode: 'CREATE_PACK_INSTALLATION',
        );
      }
      final data = InstallationAdapterUse.fromOrigin(
        InstallationDriftOriginUse.fromTableData(rows.single),
      );
      return SuccessResponseRule(data: data);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'CREATE_PACK_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> startInstallation(int installationId) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          status: Value(
            InstallationStatusEnumDatabase.values.byName(
              InstallationStatusEnumRule.installing.name,
            ),
          ),
          startedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'START_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updateProgress({
    required int installationId,
    required int progress,
  }) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          progress: Value(progress.clamp(0, 100)),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_PROGRESS',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> completeInstallation(int installationId) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          status: Value(
            InstallationStatusEnumDatabase.values.byName(
              InstallationStatusEnumRule.completed.name,
            ),
          ),
          progress: const Value(100),
          completedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'COMPLETE_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> failInstallation({
    required int installationId,
    required String errorMessage,
  }) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          status: Value(
            InstallationStatusEnumDatabase.values.byName(
              InstallationStatusEnumRule.failed.name,
            ),
          ),
          errorMessage: Value(errorMessage),
          completedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'FAIL_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> cancelInstallation(int installationId) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          status: Value(
            InstallationStatusEnumDatabase.values.byName(
              InstallationStatusEnumRule.cancelled.name,
            ),
          ),
          completedAt: Value(DateTime.now().toUtc()),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CANCEL_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> retryInstallation(int installationId) async {
    try {
      await (_db.update(_db.installationsTable)
            ..where((t) => t.id.equals(installationId)))
          .write(
        InstallationsTableCompanion(
          status: Value(
            InstallationStatusEnumDatabase.values.byName(
              InstallationStatusEnumRule.pending.name,
            ),
          ),
          progress: const Value(0),
          startedAt: const Value(null),
          completedAt: const Value(null),
          errorMessage: const Value(null),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'RETRY_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<InstallationsDataRule>> getInstallationById(
    int installationId,
  ) async {
    try {
      final rows = await (_db.select(_db.installationsTable)
            ..where((t) => t.id.equals(installationId))
            ..limit(1))
          .get();
      if (rows.isEmpty) {
        return const FailureResponseRule(
          message: 'Installation not found',
          errorCode: 'NOT_FOUND',
        );
      }
      final data = InstallationAdapterUse.fromOrigin(
        InstallationDriftOriginUse.fromTableData(rows.single),
      );
      return SuccessResponseRule(data: data);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_INSTALLATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<List<InstallationsDataRule>>>
  listInstallations() async {
    try {
      final rows = await (_db.select(_db.installationsTable)
            ..orderBy([
              (t) => OrderingTerm.desc(t.createdAt),
            ]))
          .get();
      final list = rows
          .map(
            (row) => InstallationAdapterUse.fromOrigin(
              InstallationDriftOriginUse.fromTableData(row),
            ),
          )
          .toList();
      return SuccessResponseRule(data: list);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'LIST_INSTALLATIONS',
      );
    }
  }
}
