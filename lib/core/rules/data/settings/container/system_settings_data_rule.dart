import 'package:instaboo/core/rules/enums/enums_rule.dart';

/// System settings data entity (global application settings).
/// Entidad de datos de configuración del sistema (configuraciones globales).
///
/// Maps to: system_settings table
/// Mapea a: tabla system_settings
class SystemSettingsDataRule {
  /// Primary key.
  final int id;

  /// Setting key (unique).
  final String settingKey;

  /// Setting value as text.
  final String? settingValue;

  /// Type of the setting value.
  final SettingTypeEnumRule settingType;

  /// Optional description.
  final String? description;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const SystemSettingsDataRule({
    required this.id,
    required this.settingKey,
    this.settingValue,
    this.settingType = SettingTypeEnumRule.string,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  SystemSettingsDataRule copyWith({
    int? id,
    String? settingKey,
    String? settingValue,
    SettingTypeEnumRule? settingType,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SystemSettingsDataRule(
    id: id ?? this.id,
    settingKey: settingKey ?? this.settingKey,
    settingValue: settingValue ?? this.settingValue,
    settingType: settingType ?? this.settingType,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
