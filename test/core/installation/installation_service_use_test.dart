import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instaboo/core/infra/database/app/app_database_infra.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/enums/installation/container/installation_status_enum_rule.dart';
import 'package:instaboo/core/uses/services/installation/installation_service_use.dart';

/// Unit tests for [InstallationServiceUse] running against an in-memory
/// SQLite database injected via [AppDatabaseInfra.overrideForTesting].
///
/// Pruebas unitarias de [InstallationServiceUse] sobre una base de datos
/// SQLite en memoria inyectada con [AppDatabaseInfra.overrideForTesting].
void main() {
  late AppDatabaseInfra db;
  late InstallationServiceUse service;

  setUp(() {
    // Inject a fresh in-memory database BEFORE building the service, so the
    // service's `_database = AppDatabaseInfra.instance` picks it up.
    AppDatabaseInfra.overrideForTesting(NativeDatabase.memory());
    db = AppDatabaseInfra.instance;
    service = InstallationServiceUse();
  });

  tearDown(() {
    // resetInstance() closes the in-memory db and clears the singleton.
    // The next setUp's overrideForTesting then starts from a clean slate.
    AppDatabaseInfra.resetInstance();
  });

  /// Inserts a queue row directly (bypassing FK-heavy software/installer rows).
  /// Inserta una fila de cola directamente (sin filas de software/instalador).
  Future<int> insertQueueItem(
    String name, {
    String status = 'queued',
    int? position,
  }) {
    return db.into(db.installationQueueTable).insert(
          InstallationQueueTableCompanion.insert(
            displayName: name,
            status: Value(status),
            queuePosition: Value(position),
          ),
        );
  }

  /// Unwraps a successful response or fails the test with the error message.
  /// Desempaqueta una respuesta exitosa o falla la prueba con el mensaje.
  T expectOk<T>(ResponseRule<T> response) => response.resolve(
        onSuccess: (data, _) => data,
        onFailure: (message, _) => fail('Expected success, got failure: $message'),
      );

  group('startNextInstallation', () {
    test('claims distinct items and never double-claims the same row', () async {
      await insertQueueItem('A', position: 1);
      await insertQueueItem('B', position: 2);

      final first = expectOk(await service.startNextInstallation(5));
      final second = expectOk(await service.startNextInstallation(5));
      final third = expectOk(await service.startNextInstallation(5));

      expect(first, isNotNull);
      expect(second, isNotNull);
      expect(first, isNot(equals(second)));
      expect(third, isNull, reason: 'queue exhausted -> null');
    });

    test('respects the concurrency cap', () async {
      await insertQueueItem('A', position: 1);
      await insertQueueItem('B', position: 2);

      final first = expectOk(await service.startNextInstallation(1));
      expect(first, isNotNull, reason: 'one item is now installing');

      final blocked = expectOk(await service.startNextInstallation(1));
      expect(blocked, isNull, reason: 'cap reached -> nothing else claimed');
    });

    test('claims in queue-position order', () async {
      await insertQueueItem('second', position: 2);
      final firstId = await insertQueueItem('first', position: 1);

      final claimed = expectOk(await service.startNextInstallation(5));
      expect(claimed, equals(firstId));
    });

    test('returns null when the queue is empty', () async {
      final claimed = expectOk(await service.startNextInstallation(5));
      expect(claimed, isNull);
    });
  });

  group('enqueuePending', () {
    test('moves pending -> queued and assigns positions', () async {
      await insertQueueItem('p1', status: 'pending');
      await insertQueueItem('p2', status: 'pending');

      expectOk(await service.enqueuePending());

      final queue = expectOk(await service.getQueue());
      expect(queue.length, 2);
      expect(queue.every((i) => i.status == InstallationStatusEnumRule.queued), isTrue);
      expect(queue.every((i) => i.queuePosition != null), isTrue);
    });
  });

  group('completeInstallation', () {
    test('moves an installing item to history as success', () async {
      await insertQueueItem('A', position: 1);
      final id = expectOk(await service.startNextInstallation(5));

      expectOk(await service.completeInstallation(id!));

      final queue = expectOk(await service.getQueue());
      expect(queue, isEmpty, reason: 'completed item leaves the queue');
      expect(expectOk(await service.getInstalledCount()), 1);

      final stats = expectOk(await service.getStats());
      expect(stats.totalCompleted, 1);
      expect(stats.successRate, 100.0);
    });

    test('rejects completing a non-installing item', () async {
      final id = await insertQueueItem('A', position: 1); // still "queued"
      final response = await service.completeInstallation(id);
      expect(response.isFailure, isTrue);
    });
  });

  group('failInstallation', () {
    test('moves an installing item to history as failed', () async {
      await insertQueueItem('A', position: 1);
      final id = expectOk(await service.startNextInstallation(5));

      expectOk(await service.failInstallation(id!, 'boom'));

      final queue = expectOk(await service.getQueue());
      expect(queue, isEmpty, reason: 'failed item leaves the queue');
      expect(expectOk(await service.getFailedCount()), 1);
    });
  });

  group('cancelQueueItem', () {
    test('marks a queued item as cancelled', () async {
      final id = await insertQueueItem('A', position: 1);

      expectOk(await service.cancelQueueItem(id));

      final queue = expectOk(await service.getQueue());
      expect(queue.single.status, InstallationStatusEnumRule.cancelled);
    });
  });

  group('clearQueue', () {
    test('removes every queue row regardless of status', () async {
      await insertQueueItem('a', status: 'pending');
      await insertQueueItem('b', status: 'queued', position: 1);
      await insertQueueItem('c', status: 'cancelled');
      await insertQueueItem('d', status: 'paused');

      expectOk(await service.clearQueue());

      final queue = expectOk(await service.getQueue());
      expect(queue, isEmpty);
    });
  });
}
