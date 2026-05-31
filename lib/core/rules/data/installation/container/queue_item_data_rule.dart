import 'package:instaboo/core/rules/enums/enums_rules.dart';

class QueueItemDataRule {
  final int id;
  final int? softwareId;
  final String? installerId;
  final int? packId;
  final String displayName;

  /// Typed status — use [InstallationStatusEnumRule] members and its getters
  /// (isTerminal, isInProgress) instead of raw string comparisons.
  /// Estado tipado — usar los miembros de [InstallationStatusEnumRule] y sus
  /// getters (isTerminal, isInProgress) en vez de comparar strings crudos.
  final InstallationStatusEnumRule status;

  final int progress; // 0-100
  final int? queuePosition;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? startedAt;

  const QueueItemDataRule._({
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

  factory QueueItemDataRule.fromPersisted({
    required int id,
    int? softwareId,
    String? installerId,
    int? packId,
    required String displayName,
    required String status,
    required int progress,
    int? queuePosition,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? startedAt,
  }) => QueueItemDataRule._(
    id: id,
    softwareId: softwareId,
    installerId: installerId,
    packId: packId,
    displayName: displayName,
    status: InstallationStatusEnumRule.fromRaw(status),
    progress: progress,
    queuePosition: queuePosition,
    errorMessage: errorMessage,
    createdAt: createdAt,
    updatedAt: updatedAt,
    startedAt: startedAt,
  );

  QueueItemDataRule copyWith({
    int? id,
    int? softwareId,
    String? installerId,
    int? packId,
    String? displayName,
    InstallationStatusEnumRule? status,
    int? progress,
    int? queuePosition,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
  }) => QueueItemDataRule._(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    installerId: installerId ?? this.installerId,
    packId: packId ?? this.packId,
    displayName: displayName ?? this.displayName,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    queuePosition: queuePosition ?? this.queuePosition,
    errorMessage: errorMessage ?? this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    startedAt: startedAt ?? this.startedAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueItemDataRule &&
          id == other.id &&
          softwareId == other.softwareId &&
          installerId == other.installerId &&
          packId == other.packId &&
          displayName == other.displayName &&
          status == other.status &&
          progress == other.progress &&
          queuePosition == other.queuePosition &&
          errorMessage == other.errorMessage &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          startedAt == other.startedAt;

  @override
  int get hashCode => Object.hash(
    id,
    softwareId,
    installerId,
    packId,
    displayName,
    status,
    progress,
    queuePosition,
    errorMessage,
    createdAt,
    updatedAt,
    startedAt,
  );
}
