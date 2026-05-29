/// Domain model for an installer framework type.
/// Modelo de dominio para un tipo de framework de instalador.
class InstallerFrameworkDataRule {
  final int id;
  final String name;
  final String? description;
  final String silentArgs;
  final bool isBuiltIn;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InstallerFrameworkDataRule._({
    required this.id,
    required this.name,
    this.description,
    required this.silentArgs,
    required this.isBuiltIn,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InstallerFrameworkDataRule.fromPersisted({
    required int id,
    required String name,
    String? description,
    required String silentArgs,
    required bool isBuiltIn,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => InstallerFrameworkDataRule._(
    id: id,
    name: name,
    description: description,
    silentArgs: silentArgs,
    isBuiltIn: isBuiltIn,
    sortOrder: sortOrder,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  InstallerFrameworkDataRule copyWith({
    int? id,
    String? name,
    String? description,
    String? silentArgs,
    bool? isBuiltIn,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallerFrameworkDataRule._(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    silentArgs: silentArgs ?? this.silentArgs,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() =>
      'InstallerFrameworkDataRule(id: $id, name: $name, silentArgs: $silentArgs, isBuiltIn: $isBuiltIn, sortOrder: $sortOrder)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InstallerFrameworkDataRule &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.silentArgs == silentArgs &&
        other.isBuiltIn == isBuiltIn &&
        other.sortOrder == sortOrder &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    id, name, description, silentArgs, isBuiltIn, sortOrder, createdAt, updatedAt,
  );
}
