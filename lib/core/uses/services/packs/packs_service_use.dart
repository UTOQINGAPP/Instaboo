import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Packs and pack items in SQLite; origin/adapter for [PackDataRule], software and dependency edges as in otros services.
/// Packs e ítems en SQLite; origen/adaptador para [PackDataRule], software y aristas de dependencia como en otros servicios.
class PacksServiceUse implements PacksServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  PackDataRule _packFromRow(InstallationPacksTableData row) =>
      PackAdapterUse.toDataRule(PackOriginUse.fromDrift(row));

  SoftwareDataRule _softwareFromRow(SoftwareTableData row) =>
      SoftwareAdapterUse.toDataRule(SoftwareOriginUse.fromDrift(row));

  Future<InstallationPacksTableData?> _packOrNull(int id) => (_database
          .select(_database.installationPacksTable)
        ..where((t) => t.id.equals(id)))
      .getSingleOrNull();

  @override
  Future<ResponseRule<Unit>> addSoftware(
    int packId,
    int softwareId,
    int sortOrder,
  ) async {
    try {
      if (await _packOrNull(packId) == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      final sw = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (sw == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      await _database.into(_database.packItemsTable).insert(
            PackItemsTableCompanion.insert(
              packId: packId,
              softwareId: softwareId,
              sortOrder: Value(sortOrder),
            ),
          );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<PackDataRule>> create(
    String name, {
    String? description,
    String? icon,
  }) async {
    try {
      final inserted = await _database
          .into(_database.installationPacksTable)
          .insertReturning(
            InstallationPacksTableCompanion.insert(
              name: name,
              description: description != null
                  ? Value(description)
                  : const Value.absent(),
              icon: icon != null ? Value(icon) : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _packFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> delete(int id) async {
    try {
      final n = await (_database.delete(_database.installationPacksTable)
            ..where((t) => t.id.equals(id)))
          .go();
      if (n == 0) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<PackDataRule>>> getAll({bool? activeOnly}) async {
    try {
      final q = _database.select(_database.installationPacksTable);
      if (activeOnly == true) {
        q.where((t) => t.isActive.equals(true));
      }
      q.orderBy([(t) => OrderingTerm.asc(t.name)]);
      final rows = await q.get();
      return SuccessResponseRule(
        data: rows.map(_packFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<PackDataRule>> getById(int id) async {
    try {
      final row = await _packOrNull(id);
      if (row == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      return SuccessResponseRule(data: _packFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<PackDetailDataRule>> getPackDetail(int packId) async {
    try {
      final packRow = await _packOrNull(packId);
      if (packRow == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      final items = await (_database.select(_database.packItemsTable)
            ..where((t) => t.packId.equals(packId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();
      final softwareList = <SoftwareDataRule>[];
      final softwareIds = <int>[];
      for (final item in items) {
        final sw = await (_database.select(_database.softwareTable)
              ..where((t) => t.id.equals(item.softwareId)))
            .getSingleOrNull();
        if (sw != null) {
          softwareList.add(_softwareFromRow(sw));
          softwareIds.add(sw.id);
        }
      }
      final deps = <DependencyDataRule>[];
      if (softwareIds.isNotEmpty) {
        final depRows = await (_database
                .select(_database.softwareDependenciesTable)
              ..where((t) => t.softwareId.isIn(softwareIds)))
            .get();
        for (final d in depRows) {
          deps.add(
            DependencyAdapterUse.toDataRule(
              DependencyOriginUse.fromDrift(d),
            ),
          );
        }
      }
      final detail = PackDetailDataRule.fromAggregate(
        id: packRow.id,
        name: packRow.name,
        description: packRow.description,
        icon: packRow.icon,
        isActive: packRow.isActive,
        createdAt: packRow.createdAt,
        updatedAt: packRow.updatedAt,
        software: softwareList,
        allDependencies: deps,
        totalSoftwareCount: softwareList.length,
        estimatedTotalSizeBytes: null,
      );
      return SuccessResponseRule(data: detail);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> getSoftwareInPack(
    int packId,
  ) async {
    try {
      if (await _packOrNull(packId) == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      final items = await (_database.select(_database.packItemsTable)
            ..where((t) => t.packId.equals(packId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();
      final out = <SoftwareDataRule>[];
      for (final item in items) {
        final sw = await (_database.select(_database.softwareTable)
              ..where((t) => t.id.equals(item.softwareId)))
            .getSingleOrNull();
        if (sw != null) {
          out.add(_softwareFromRow(sw));
        }
      }
      return SuccessResponseRule(data: out);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> removeSoftware(int packId, int softwareId) async {
    try {
      final n = await (_database.delete(_database.packItemsTable)
            ..where(
              (t) =>
                  t.packId.equals(packId) & t.softwareId.equals(softwareId),
            ))
          .go();
      if (n == 0) {
        return const FailureResponseRule(message: 'Pack item not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> reorderSoftware(
    int packId,
    int softwareId,
    int newSortOrder,
  ) async {
    try {
      final n = await (_database.update(_database.packItemsTable)
            ..where(
              (t) =>
                  t.packId.equals(packId) & t.softwareId.equals(softwareId),
            ))
          .write(
        PackItemsTableCompanion(
          sortOrder: Value(newSortOrder),
        ),
      );
      if (n == 0) {
        return const FailureResponseRule(message: 'Pack item not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> toggleActive(int id, bool isActive) async {
    try {
      final n = await (_database.update(_database.installationPacksTable)
            ..where((t) => t.id.equals(id)))
          .write(
        InstallationPacksTableCompanion(
          isActive: Value(isActive),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (n == 0) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<PackDataRule>> update(
    int id, {
    String? name,
    String? description,
    String? icon,
  }) async {
    try {
      if (await _packOrNull(id) == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      await (_database.update(_database.installationPacksTable)
            ..where((t) => t.id.equals(id)))
          .write(
        InstallationPacksTableCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          description: description != null
              ? Value(description)
              : const Value.absent(),
          icon: icon != null ? Value(icon) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );
      final updated = await (_database.select(_database.installationPacksTable)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      return SuccessResponseRule(data: _packFromRow(updated));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }
}
