class SettingDataRule {
  final String key;
  final dynamic value;
  final String valueType; // string, integer, boolean, json
  final String? description;
  final DateTime updatedAt;

  const SettingDataRule._({
    required this.key,
    required this.value,
    required this.valueType,
    this.description,
    required this.updatedAt,
  });

  factory SettingDataRule.fromPersisted({
    required String key,
    required dynamic value,
    required String valueType,
    String? description,
    required DateTime updatedAt,
  }) => SettingDataRule._(
    key: key,
    value: value,
    valueType: valueType,
    description: description,
    updatedAt: updatedAt,
  );

  SettingDataRule copyWith({
    String? key,
    dynamic value,
    String? valueType,
    String? description,
    DateTime? updatedAt,
  }) => SettingDataRule._(
    key: key ?? this.key,
    value: value ?? this.value,
    valueType: valueType ?? this.valueType,
    description: description ?? this.description,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() {
    return 'SettingDataRule(key: $key, value: $value, valueType: $valueType, description: $description, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingDataRule &&
        other.key == key &&
        other.value == value &&
        other.valueType == valueType &&
        other.description == description &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        value.hashCode ^
        valueType.hashCode ^
        description.hashCode ^
        updatedAt.hashCode;
  }
}
