import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/installation/installation_origins_uses.dart';

/// Maps [QueueItemOriginUse] ↔ [QueueItemDataRule].
/// Mapea [QueueItemOriginUse] ↔ [QueueItemDataRule].
class QueueItemAdapterUse {
  static QueueItemDataRule toDataRule(QueueItemOriginUse o) =>
      QueueItemDataRule.fromPersisted(
        id: o.id,
        softwareId: o.softwareId,
        installerId: o.installerId,
        packId: o.packId,
        displayName: o.displayName,
        status: o.status,
        progress: o.progress,
        queuePosition: o.queuePosition,
        errorMessage: o.errorMessage,
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
        startedAt: o.startedAt,
      );

  static QueueItemOriginUse toOriginUse(QueueItemDataRule d) =>
      QueueItemOriginUse(
        id: d.id,
        softwareId: d.softwareId,
        installerId: d.installerId,
        packId: d.packId,
        displayName: d.displayName,
        status: d.status.name, // enum → raw string for persistence layer
        progress: d.progress,
        queuePosition: d.queuePosition,
        errorMessage: d.errorMessage,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
        startedAt: d.startedAt,
      );
}
