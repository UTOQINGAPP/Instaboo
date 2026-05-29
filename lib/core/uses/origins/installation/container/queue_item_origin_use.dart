import 'package:instaboo/core/infra/infra_core.dart';

/// Raw installation queue row from Drift.
/// Fila de cola de instalación cruda desde Drift.
class QueueItemOriginUse {
  final int id;
  final int? softwareId;
  final String? installerId;
  final int? packId;
  final String displayName;
  final String status;
  final int progress;
  final int? queuePosition;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? startedAt;

  const QueueItemOriginUse({
    required this.id,
    this.softwareId,
    this.installerId,
    this.packId,
    required this.displayName,
    required this.status,
    required this.progress,
    this.queuePosition,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory QueueItemOriginUse.fromDrift(InstallationQueueTableData row) =>
      QueueItemOriginUse(
        id: row.id,
        softwareId: row.softwareId,
        installerId: row.installerId,
        packId: row.packId,
        displayName: row.displayName,
        status: row.status,
        progress: row.progress,
        queuePosition: row.queuePosition,
        errorMessage: row.errorMessage,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        startedAt: row.startedAt,
      );
}
