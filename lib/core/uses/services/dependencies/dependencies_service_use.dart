import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Software dependency edges in SQLite; origin/adapter for [DependencyDataRule] and software lists.
/// Aristas de dependencia en SQLite; origen/adaptador para [DependencyDataRule] y listas de software.
class DependenciesServiceUse implements DependenciesServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  DependencyDataRule _dependencyFromRow(SoftwareDependenciesTableData row) =>
      DependencyAdapterUse.toDataRule(DependencyOriginUse.fromDrift(row));

  SoftwareDataRule _softwareFromRow(SoftwareTableData row) =>
      SoftwareAdapterUse.toDataRule(SoftwareOriginUse.fromDrift(row));

  /// True if there is a path `start` → … → `target` following dependency edges
  /// (`softwareId` → `dependencySoftwareId`).
  /// Verdadero si existe camino `start` → … → `target` siguiendo aristas de dependencia.
  Future<bool> _canReach(int start, int target) async {
    if (start == target) {
      return true;
    }
    final stack = <int>[start];
    final seen = <int>{start};
    while (stack.isNotEmpty) {
      final cur = stack.removeLast();
      final outs = await (_database.select(_database.softwareDependenciesTable)
            ..where((t) => t.softwareId.equals(cur)))
          .get();
      for (final e in outs) {
        final next = e.dependencySoftwareId;
        if (next == target) {
          return true;
        }
        if (seen.add(next)) {
          stack.add(next);
        }
      }
    }
    return false;
  }

  Future<SoftwareTableData?> _softwareOrNull(int id) => (_database
          .select(_database.softwareTable)
        ..where((t) => t.id.equals(id)))
      .getSingleOrNull();

  /// Collects transitive dependency software ids for [rootId] in install order (deps before dependents).
  /// Recopila ids de dependencias transitivas de [rootId] en orden de instalación.
  Future<List<int>> _orderedDependencyIds(int rootId) async {
    final visiting = <int>{};
    final ordered = <int>[];
    final direct = await (_database.select(_database.softwareDependenciesTable)
          ..where((t) => t.softwareId.equals(rootId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
    for (final e in direct) {
      await _collectPostOrder(e.dependencySoftwareId, visiting, ordered);
    }
    return ordered;
  }

  Future<void> _collectPostOrder(
    int sid,
    Set<int> visiting,
    List<int> ordered,
  ) async {
    if (ordered.contains(sid)) {
      return;
    }
    if (visiting.contains(sid)) {
      return;
    }
    visiting.add(sid);
    final edges = await (_database.select(_database.softwareDependenciesTable)
          ..where((t) => t.softwareId.equals(sid))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
    for (final e in edges) {
      await _collectPostOrder(e.dependencySoftwareId, visiting, ordered);
    }
    visiting.remove(sid);
    if (!ordered.contains(sid)) {
      ordered.add(sid);
    }
  }

  @override
  Future<ResponseRule<DependencyDataRule>> addDependency(
    int softwareId,
    int dependencySoftwareId, {
    bool isRequired = true,
    String? notes,
  }) async {
    try {
      if (softwareId == dependencySoftwareId) {
        return const FailureResponseRule(
          message: 'A software cannot depend on itself.',
        );
      }
      final a = await _softwareOrNull(softwareId);
      final b = await _softwareOrNull(dependencySoftwareId);
      if (a == null || b == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      if (await _canReach(dependencySoftwareId, softwareId)) {
        return const FailureResponseRule(
          message: 'This dependency would create a cycle.',
        );
      }
      final inserted = await _database
          .into(_database.softwareDependenciesTable)
          .insertReturning(
            SoftwareDependenciesTableCompanion.insert(
              softwareId: softwareId,
              dependencySoftwareId: dependencySoftwareId,
              isRequired: Value(isRequired),
              notes: notes != null ? Value(notes) : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _dependencyFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<bool>> checkCircularDependency(
    int softwareId,
    int potentialDependencyId,
  ) async {
    try {
      if (softwareId == potentialDependencyId) {
        return const SuccessResponseRule(data: true);
      }
      final wouldCycle =
          await _canReach(potentialDependencyId, softwareId);
      return SuccessResponseRule(data: wouldCycle);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> getDependencies(
    int softwareId, {
    bool? onlyRequired,
  }) async {
    try {
      if (await _softwareOrNull(softwareId) == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final q = _database.select(_database.softwareDependenciesTable)
        ..where((t) => t.softwareId.equals(softwareId));
      if (onlyRequired == true) {
        q.where((t) => t.isRequired.equals(true));
      }
      q.orderBy([(t) => OrderingTerm.asc(t.id)]);
      final edges = await q.get();
      final out = <SoftwareDataRule>[];
      for (final e in edges) {
        final sw = await _softwareOrNull(e.dependencySoftwareId);
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
  Future<ResponseRule<List<SoftwareDataRule>>> getDependents(int softwareId) async {
    try {
      if (await _softwareOrNull(softwareId) == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final edges = await (_database.select(_database.softwareDependenciesTable)
            ..where((t) => t.dependencySoftwareId.equals(softwareId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
      final out = <SoftwareDataRule>[];
      for (final e in edges) {
        final sw = await _softwareOrNull(e.softwareId);
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
  Future<ResponseRule<Unit>> removeDependency(
    int softwareId,
    int dependencySoftwareId,
  ) async {
    try {
      final n = await (_database.delete(_database.softwareDependenciesTable)
            ..where(
              (t) =>
                  t.softwareId.equals(softwareId) &
                  t.dependencySoftwareId.equals(dependencySoftwareId),
            ))
          .go();
      if (n == 0) {
        return const FailureResponseRule(message: 'Dependency not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<SoftwareDataRule>>> resolveDependencyTree(
    int softwareId,
  ) async {
    try {
      if (await _softwareOrNull(softwareId) == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final ids = await _orderedDependencyIds(softwareId);
      final out = <SoftwareDataRule>[];
      for (final id in ids) {
        final sw = await _softwareOrNull(id);
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
  Future<ResponseRule<Unit>> updateDependency(
    int softwareId,
    int dependencySoftwareId, {
    bool? isRequired,
    String? notes,
  }) async {
    try {
      final existing = await (_database.select(_database.softwareDependenciesTable)
            ..where(
              (t) =>
                  t.softwareId.equals(softwareId) &
                  t.dependencySoftwareId.equals(dependencySoftwareId),
            ))
          .getSingleOrNull();
      if (existing == null) {
        return const FailureResponseRule(message: 'Dependency not found.');
      }
      await (_database.update(_database.softwareDependenciesTable)
            ..where(
              (t) =>
                  t.softwareId.equals(softwareId) &
                  t.dependencySoftwareId.equals(dependencySoftwareId),
            ))
          .write(
        SoftwareDependenciesTableCompanion(
          isRequired: isRequired != null
              ? Value(isRequired)
              : const Value.absent(),
          notes: notes != null ? Value(notes) : const Value.absent(),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }
}
