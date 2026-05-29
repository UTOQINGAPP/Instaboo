class CategoryDataRule {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final int sortOrder;
  final int? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryDataRule._({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.sortOrder,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDataRule.fromPersisted({
    required int id,
    required String name,
    String? description,
    String? icon,
    required int sortOrder,
    int? parentId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => CategoryDataRule._(
    id: id,
    name: name,
    description: description,
    icon: icon,
    sortOrder: sortOrder,
    parentId: parentId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  CategoryDataRule copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    int? sortOrder,
    int? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoryDataRule._(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    sortOrder: sortOrder ?? this.sortOrder,
    parentId: parentId ?? this.parentId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() {
    return 'CategoryDataRule(id: $id, name: $name, description: $description, icon: $icon, sortOrder: $sortOrder, parentId: $parentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryDataRule &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.sortOrder == sortOrder &&
        other.parentId == parentId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        sortOrder.hashCode ^
        parentId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
