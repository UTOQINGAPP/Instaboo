class PackDataRule {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PackDataRule._({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PackDataRule.fromPersisted({
    required int id,
    required String name,
    String? description,
    String? icon,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => PackDataRule._(
    id: id,
    name: name,
    description: description,
    icon: icon,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  PackDataRule copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PackDataRule._(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() {
    return 'PackDataRule(id: $id, name: $name, description: $description, icon: $icon, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PackDataRule &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
