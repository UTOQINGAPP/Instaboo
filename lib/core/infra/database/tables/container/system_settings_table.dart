import 'package:drift/drift.dart';

import '../../enums/enums_database.dart';

/// Global application settings.
/// Configuraciones globales de la aplicación.
///
/// Maps to PostgreSQL: system_settings
/// Mapea a PostgreSQL: system_settings
@TableIndex(name: 'idx_system_settings_setting_key', columns: {#settingKey})
class SystemSettingsTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Setting key (unique).
  TextColumn get settingKey => text().withLength(max: 100).unique()();

  /// Setting value as text.
  TextColumn get settingValue => text().nullable()();

  /// Type of the setting value.
  TextColumn get settingType => textEnum<SettingTypeEnumDatabase>().withDefault(
    const Constant('string'),
  )();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
