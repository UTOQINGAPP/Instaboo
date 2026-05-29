class LogDataRule {
  final int id;
  final String level; // debug, info, warning, error
  final String message;
  final String? context; // installer, queue, pack, startup, etc.
  final String? referenceId; // ID genérico para vincular con cualquier entidad
  final DateTime createdAt;

  const LogDataRule._({
    required this.id,
    required this.level,
    required this.message,
    this.context,
    this.referenceId,
    required this.createdAt,
  });

  factory LogDataRule.fromPersisted({
    required int id,
    required String level,
    required String message,
    String? context,
    String? referenceId,
    required DateTime createdAt,
  }) => LogDataRule._(
    id: id,
    level: level,
    message: message,
    context: context,
    referenceId: referenceId,
    createdAt: createdAt,
  );

  LogDataRule copyWith({
    int? id,
    String? level,
    String? message,
    String? context,
    String? referenceId,
    DateTime? createdAt,
  }) => LogDataRule._(
    id: id ?? this.id,
    level: level ?? this.level,
    message: message ?? this.message,
    context: context ?? this.context,
    referenceId: referenceId ?? this.referenceId,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() {
    return 'LogDataRule(id: $id, level: $level, message: $message, context: $context, referenceId: $referenceId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LogDataRule &&
        other.id == id &&
        other.level == level &&
        other.message == message &&
        other.context == context &&
        other.referenceId == referenceId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        level.hashCode ^
        message.hashCode ^
        context.hashCode ^
        referenceId.hashCode ^
        createdAt.hashCode;
  }
}
