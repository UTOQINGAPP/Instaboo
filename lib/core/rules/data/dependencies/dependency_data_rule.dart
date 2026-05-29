class DependencyDataRule {
  final int id;
  final int softwareId;
  final int dependencySoftwareId;
  final bool isRequired;
  final String? notes;
  final DateTime createdAt;

  const DependencyDataRule._({
    required this.id,
    required this.softwareId,
    required this.dependencySoftwareId,
    required this.isRequired,
    this.notes,
    required this.createdAt,
  });

  factory DependencyDataRule.fromPersisted({
    required int id,
    required int softwareId,
    required int dependencySoftwareId,
    required bool isRequired,
    String? notes,
    required DateTime createdAt,
  }) => DependencyDataRule._(
    id: id,
    softwareId: softwareId,
    dependencySoftwareId: dependencySoftwareId,
    isRequired: isRequired,
    notes: notes,
    createdAt: createdAt,
  );

  DependencyDataRule copyWith({
    int? id,
    int? softwareId,
    int? dependencySoftwareId,
    bool? isRequired,
    String? notes,
    DateTime? createdAt,
  }) => DependencyDataRule._(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
    isRequired: isRequired ?? this.isRequired,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() {
    return 'DependencyDataRule(id: $id, softwareId: $softwareId, dependencySoftwareId: $dependencySoftwareId, isRequired: $isRequired, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DependencyDataRule &&
        other.id == id &&
        other.softwareId == softwareId &&
        other.dependencySoftwareId == dependencySoftwareId &&
        other.isRequired == isRequired &&
        other.notes == notes &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        softwareId.hashCode ^
        dependencySoftwareId.hashCode ^
        isRequired.hashCode ^
        notes.hashCode ^
        createdAt.hashCode;
  }
}
