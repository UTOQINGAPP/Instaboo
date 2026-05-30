import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Installation queue and history backed by SQLite; uses origin/adapter for queue and history data rules.
/// Cola e historial de instalación en SQLite; origen/adaptador para reglas de cola e historial.
class InstallationServiceUse implements InstallationServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  QueueItemDataRule _queueFromRow(InstallationQueueTableData row) =>
      QueueItemAdapterUse.toDataRule(QueueItemOriginUse.fromDrift(row));

  HistoryDataRule _historyFromRow(InstallationHistoryTableData row) =>
      HistoryAdapterUse.toDataRule(HistoryOriginUse.fromDrift(row));

  bool _isSameCalendarDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Future<ResponseRule<Unit>> cancelQueueItem(int queueItemId) async {
    try {
      final row = await (_database.select(_database.installationQueueTable)
            ..where((t) => t.id.equals(queueItemId)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Queue item not found.');
      }
      if (row.status == 'cancelled') {
        return const SuccessResponseRule(data: unit);
      }
      if (row.status == 'installing' ||
          row.status == 'queued' ||
          row.status == 'pending' ||
          row.status == 'paused') {
        await (_database.update(_database.installationQueueTable)
              ..where((t) => t.id.equals(queueItemId)))
            .write(
          InstallationQueueTableCompanion(
            status: const Value('cancelled'),
            updatedAt: Value(DateTime.now()),
          ),
        );
        return const SuccessResponseRule(data: unit);
      }
      return const FailureResponseRule(
        message: 'Item cannot be cancelled in its current state.',
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> completeInstallation(int queueItemId) async {
    try {
      final q = await (_database.select(_database.installationQueueTable)
            ..where((t) => t.id.equals(queueItemId)))
          .getSingleOrNull();
      if (q == null) {
        return const FailureResponseRule(message: 'Queue item not found.');
      }
      if (q.status != 'installing') {
        return const FailureResponseRule(
          message: 'Only installing items can be completed.',
        );
      }
      final now = DateTime.now();
      var softwareName = q.displayName;
      String? softwareVersion;
      String? installerType;
      if (q.softwareId != null) {
        final sw = await (_database.select(_database.softwareTable)
              ..where((t) => t.id.equals(q.softwareId!)))
            .getSingleOrNull();
        if (sw != null) {
          softwareName = sw.name;
          softwareVersion = sw.version;
          if (sw.installerId != null) {
            final inst = await (_database.select(_database.installersTable)
                  ..where((t) => t.id.equals(sw.installerId!)))
                .getSingleOrNull();
            installerType = inst?.installerType;
          }
        }
      }
      final startedAt = q.startedAt ?? now;

      // Collect machine info once (cached after first call).
      // Recopila info del equipo una vez (cacheada tras la primera llamada).
      final machineJson = await MachineInfoCollectorInfra.instance.toJson();

      await _database.transaction(() async {
        await _database.into(_database.installationHistoryTable).insert(
              InstallationHistoryTableCompanion.insert(
                softwareId: q.softwareId != null
                    ? Value(q.softwareId!)
                    : const Value.absent(),
                packId: q.packId != null ? Value(q.packId!) : const Value.absent(),
                softwareName: softwareName,
                softwareVersion: softwareVersion != null
                    ? Value(softwareVersion)
                    : const Value.absent(),
                installerType: installerType != null
                    ? Value(installerType)
                    : const Value.absent(),
                status: 'success',
                startedAt: startedAt,
                completedAt: now,
                machineInfo: machineJson != null
                    ? Value(machineJson)
                    : const Value.absent(),
              ),
            );
        await (_database.delete(_database.installationQueueTable)
              ..where((t) => t.id.equals(queueItemId)))
            .go();
      });
      await InstallationReportInfra.writeReport(
        softwareName: softwareName,
        softwareVersion: softwareVersion,
        installerType: installerType,
        status: 'exitoso',
        startedAt: startedAt,
        completedAt: now,
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> enqueuePending() async {
    try {
      await _database.transaction(() async {
        final pending = await (_database.select(_database.installationQueueTable)
              ..where((t) => t.status.equals('pending'))
              ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
            .get();
        if (pending.isEmpty) {
          return;
        }
        final queued = await (_database.select(_database.installationQueueTable)
              ..where((t) => t.status.equals('queued')))
            .get();
        var base = 0;
        for (final item in queued) {
          final p = item.queuePosition ?? 0;
          if (p > base) {
            base = p;
          }
        }
        var idx = 0;
        for (final item in pending) {
          idx++;
          await (_database.update(_database.installationQueueTable)
                ..where((t) => t.id.equals(item.id)))
              .write(
            InstallationQueueTableCompanion(
              status: const Value('queued'),
              queuePosition: Value(base + idx),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      });
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> failInstallation(
    int queueItemId,
    String errorMessage,
  ) async {
    try {
      final q = await (_database.select(_database.installationQueueTable)
            ..where((t) => t.id.equals(queueItemId)))
          .getSingleOrNull();
      if (q == null) {
        return const FailureResponseRule(message: 'Queue item not found.');
      }
      if (q.status != 'installing' && q.status != 'queued') {
        return const FailureResponseRule(
          message: 'Item cannot fail in its current state.',
        );
      }
      final now = DateTime.now();
      var softwareName = q.displayName;
      String? softwareVersion;
      String? installerType;
      if (q.softwareId != null) {
        final sw = await (_database.select(_database.softwareTable)
              ..where((t) => t.id.equals(q.softwareId!)))
            .getSingleOrNull();
        if (sw != null) {
          softwareName = sw.name;
          softwareVersion = sw.version;
          if (sw.installerId != null) {
            final inst = await (_database.select(_database.installersTable)
                  ..where((t) => t.id.equals(sw.installerId!)))
                .getSingleOrNull();
            installerType = inst?.installerType;
          }
        }
      }
      final startedAt = q.startedAt ?? q.createdAt;

      // Collect machine info once (cached after first call).
      // Recopila info del equipo una vez (cacheada tras la primera llamada).
      final machineJson = await MachineInfoCollectorInfra.instance.toJson();

      await _database.transaction(() async {
        await _database.into(_database.installationHistoryTable).insert(
              InstallationHistoryTableCompanion.insert(
                softwareId: q.softwareId != null
                    ? Value(q.softwareId!)
                    : const Value.absent(),
                packId: q.packId != null ? Value(q.packId!) : const Value.absent(),
                softwareName: softwareName,
                softwareVersion: softwareVersion != null
                    ? Value(softwareVersion)
                    : const Value.absent(),
                installerType: installerType != null
                    ? Value(installerType)
                    : const Value.absent(),
                status: 'failed',
                errorDetails: Value(errorMessage),
                startedAt: startedAt,
                completedAt: now,
                machineInfo: machineJson != null
                    ? Value(machineJson)
                    : const Value.absent(),
              ),
            );
        await (_database.delete(_database.installationQueueTable)
              ..where((t) => t.id.equals(queueItemId)))
            .go();
      });
      await InstallationReportInfra.writeReport(
        softwareName: softwareName,
        softwareVersion: softwareVersion,
        installerType: installerType,
        status: 'fallido',
        startedAt: startedAt,
        completedAt: now,
        errorDetails: errorMessage,
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<int>> getFailedCount({DateTime? sinceDate}) async {
    try {
      final rows = await (_database.select(_database.installationHistoryTable)
            ..where((t) {
              Expression<bool> e = t.status.equals('failed');
              if (sinceDate != null) {
                e = e & t.completedAt.isBiggerOrEqualValue(sinceDate);
              }
              return e;
            }))
          .get();
      return SuccessResponseRule(data: rows.length);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<HistoryDataRule>>> getHistory({
    int? softwareId,
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final rows = await (_database.select(_database.installationHistoryTable)
            ..where((t) {
              Expression<bool> e = const Constant(true);
              final sid = softwareId;
              if (sid != null) {
                e = e & t.softwareId.equals(sid);
              }
              final st = status;
              if (st != null) {
                e = e & t.status.equals(st);
              }
              final from = fromDate;
              if (from != null) {
                e = e & t.completedAt.isBiggerOrEqualValue(from);
              }
              final to = toDate;
              if (to != null) {
                e = e & t.completedAt.isSmallerOrEqualValue(to);
              }
              return e;
            })
            ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
          .get();
      return SuccessResponseRule(
        data: rows.map(_historyFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<HistoryDataRule>> getHistoryDetail(int historyId) async {
    try {
      final row = await (_database.select(_database.installationHistoryTable)
            ..where((t) => t.id.equals(historyId)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'History entry not found.');
      }
      return SuccessResponseRule(data: _historyFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<int>> getInstalledCount() async {
    try {
      final rows = await (_database.select(_database.installationHistoryTable)
            ..where((t) => t.status.equals('success')))
          .get();
      return SuccessResponseRule(data: rows.length);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<List<QueueItemDataRule>>> getQueue({String? status}) async {
    try {
      final q = _database.select(_database.installationQueueTable);
      if (status != null) {
        q.where((t) => t.status.equals(status));
      }
      q.orderBy([
        (t) => OrderingTerm.asc(t.queuePosition),
        (t) => OrderingTerm.asc(t.createdAt),
      ]);
      final rows = await q.get();
      return SuccessResponseRule(
        data: rows.map(_queueFromRow).toList(),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Stream<List<QueueItemDataRule>> watchQueue() {
    final q = _database.select(_database.installationQueueTable)
      ..orderBy([
        (t) => OrderingTerm.asc(t.queuePosition),
        (t) => OrderingTerm.asc(t.createdAt),
      ]);
    return q.watch().map((rows) => rows.map(_queueFromRow).toList());
  }

  @override
  Future<ResponseRule<InstallationStatsDataRule>> getStats() async {
    try {
      final queueRows = await _database.select(_database.installationQueueTable).get();
      final historyRows =
          await _database.select(_database.installationHistoryTable).get();

      final totalQueued = queueRows
          .where((r) => r.status == 'pending' || r.status == 'queued')
          .length;
      final currentlyInstalling =
          queueRows.where((r) => r.status == 'installing').length;

      final totalCompleted =
          historyRows.where((r) => r.status == 'success').length;
      final totalFailed = historyRows.where((r) => r.status == 'failed').length;
      final totalCancelledHistory =
          historyRows.where((r) => r.status == 'cancelled').length;
      final totalCancelledQueue =
          queueRows.where((r) => r.status == 'cancelled').length;
      final totalCancelled = totalCancelledHistory + totalCancelledQueue;

      final denom = totalCompleted + totalFailed;
      final successRate =
          denom == 0 ? 0.0 : (totalCompleted / denom) * 100.0;

      final today = DateTime.now();
      int completedToday = 0;
      int failedToday = 0;
      for (final h in historyRows) {
        if (!_isSameCalendarDay(h.completedAt, today)) {
          continue;
        }
        if (h.status == 'success') {
          completedToday++;
        } else if (h.status == 'failed') {
          failedToday++;
        }
      }

      Duration? averageInstallationTime;
      final successRows =
          historyRows.where((r) => r.status == 'success').toList();
      if (successRows.isNotEmpty) {
        var sumMs = 0;
        for (final h in successRows) {
          sumMs += h.completedAt.difference(h.startedAt).inMilliseconds;
        }
        averageInstallationTime =
            Duration(milliseconds: sumMs ~/ successRows.length);
      }

      DateTime? lastCompletedAt;
      DateTime? lastFailedAt;
      for (final h in historyRows) {
        if (h.status == 'success') {
          if (lastCompletedAt == null ||
              h.completedAt.isAfter(lastCompletedAt)) {
            lastCompletedAt = h.completedAt;
          }
        } else if (h.status == 'failed') {
          if (lastFailedAt == null || h.completedAt.isAfter(lastFailedAt)) {
            lastFailedAt = h.completedAt;
          }
        }
      }

      return SuccessResponseRule(
        data: InstallationStatsDataRule.fromCounts(
          totalQueued: totalQueued,
          currentlyInstalling: currentlyInstalling,
          totalCompleted: totalCompleted,
          totalFailed: totalFailed,
          totalCancelled: totalCancelled,
          successRate: successRate,
          completedToday: completedToday,
          failedToday: failedToday,
          averageInstallationTime: averageInstallationTime,
          lastCompletedAt: lastCompletedAt,
          lastFailedAt: lastFailedAt,
        ),
      );
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> pauseQueue() async {
    try {
      await (_database.update(_database.installationQueueTable)
            ..where(
              (t) =>
                  t.status.equals('pending') |
                  t.status.equals('queued') |
                  t.status.equals('installing'),
            ))
          .write(
        InstallationQueueTableCompanion(
          status: const Value('paused'),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<QueueItemDataRule>> queuePack(int packId) async {
    try {
      final pack = await (_database.select(_database.installationPacksTable)
            ..where((t) => t.id.equals(packId)))
          .getSingleOrNull();
      if (pack == null) {
        return const FailureResponseRule(message: 'Pack not found.');
      }
      final inserted = await _database
          .into(_database.installationQueueTable)
          .insertReturning(
            InstallationQueueTableCompanion.insert(
              displayName: pack.name,
              packId: Value(packId),
            ),
          );
      return SuccessResponseRule(data: _queueFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> clearQueue() async {
    try {
      await _database.delete(_database.installationQueueTable).go();
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<QueueItemDataRule>> queueSoftware(
    int softwareId, {
    int? packId,
  }) async {
    try {
      final sw = await (_database.select(_database.softwareTable)
            ..where((t) => t.id.equals(softwareId)))
          .getSingleOrNull();
      if (sw == null) {
        return const FailureResponseRule(message: 'Software not found.');
      }
      final inserted = await _database
          .into(_database.installationQueueTable)
          .insertReturning(
            InstallationQueueTableCompanion.insert(
              displayName: sw.name,
              softwareId: Value(softwareId),
              packId: packId != null ? Value(packId) : const Value.absent(),
              installerId: sw.installerId != null
                  ? Value(sw.installerId!)
                  : const Value.absent(),
            ),
          );
      return SuccessResponseRule(data: _queueFromRow(inserted));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> startInstallation() async {
    try {
      final inProgress = await (_database.select(_database.installationQueueTable)
            ..where((t) => t.status.equals('installing')))
          .get();
      if (inProgress.isNotEmpty) {
        return const FailureResponseRule(
          message: 'An installation is already in progress.',
        );
      }
      final candidates = await (_database.select(_database.installationQueueTable)
            ..where((t) => t.status.equals('queued'))
            ..orderBy([
              (t) => OrderingTerm.asc(t.queuePosition),
              (t) => OrderingTerm.asc(t.createdAt),
            ]))
          .get();
      if (candidates.isEmpty) {
        return const FailureResponseRule(message: 'No queued items.');
      }
      final next = candidates.first;
      final now = DateTime.now();
      await (_database.update(_database.installationQueueTable)
            ..where((t) => t.id.equals(next.id)))
          .write(
        InstallationQueueTableCompanion(
          status: const Value('installing'),
          progress: const Value(0),
          startedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<int?>> startNextInstallation(int maxConcurrent) async {
    // Loop with optimistic locking: retry when a concurrent caller claims the
    // same row between our SELECT and our UPDATE (TOCTOU prevention).
    //
    // Bucle con bloqueo optimista: reintenta cuando un llamador concurrente
    // reclama la misma fila entre nuestro SELECT y nuestro UPDATE.
    try {
      while (true) {
        // Check concurrency cap.
        // Verifica el límite de concurrencia.
        final inProgress = await (_database
                .select(_database.installationQueueTable)
              ..where((t) => t.status.equals('installing')))
            .get();
        if (inProgress.length >= maxConcurrent) {
          return const SuccessResponseRule(data: null);
        }

        // Find the highest-priority queued item.
        // Encuentra el item en cola de mayor prioridad.
        final candidates = await (_database
                .select(_database.installationQueueTable)
              ..where((t) => t.status.equals('queued'))
              ..orderBy([
                (t) => OrderingTerm.asc(t.queuePosition),
                (t) => OrderingTerm.asc(t.createdAt),
              ]))
            .get();
        if (candidates.isEmpty) {
          return const SuccessResponseRule(data: null);
        }

        final next = candidates.first;
        final now = DateTime.now();

        // Atomic claim: update only if the row is still 'queued'.
        // If a concurrent caller already claimed it, affected == 0 → retry.
        //
        // Reclamo atómico: actualiza solo si la fila sigue en 'queued'.
        // Si un llamador concurrente ya la reclamó, affected == 0 → reintenta.
        final affected = await (_database
                .update(_database.installationQueueTable)
              ..where(
                (t) => t.id.equals(next.id) & t.status.equals('queued'),
              ))
            .write(
          InstallationQueueTableCompanion(
            status: const Value('installing'),
            progress: const Value(0),
            startedAt: Value(now),
            updatedAt: Value(now),
          ),
        );

        if (affected > 0) {
          return SuccessResponseRule(data: next.id);
        }
        // affected == 0 → another caller won the race; loop to find the next item.
        // affected == 0 → otro llamador ganó la carrera; itera para encontrar el siguiente.
      }
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> updateProgress(int queueItemId, int progress) async {
    try {
      final clamped = progress.clamp(0, 100);
      final n = await (_database.update(_database.installationQueueTable)
            ..where((t) => t.id.equals(queueItemId)))
          .write(
        InstallationQueueTableCompanion(
          progress: Value(clamped),
          updatedAt: Value(DateTime.now()),
        ),
      );
      if (n == 0) {
        return const FailureResponseRule(message: 'Queue item not found.');
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }
}
