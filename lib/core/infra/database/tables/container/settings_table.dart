import 'package:drift/drift.dart';

/// Key–value settings (`string`, `integer`, `boolean`, `json` as text labels).
/// Configuración clave–valor (tipos como etiquetas de texto).
class SettingsTable extends Table {
  @override
  String get tableName => 'settings';

  @override
  Set<Column> get primaryKey => {prefKey};

  /// Setting key (max 100).
  TextColumn get prefKey => text().withLength(max: 100).named('key')();

  /// Serialized value.
  TextColumn get prefValue => text().nullable().named('value')();

  /// `string`, `integer`, `boolean`, or `json` (plain text from rules).
  TextColumn get valueType =>
      text().withDefault(const Constant('string')).named('value_type')();

  /// Human-readable description.
  TextColumn get description => text().nullable()();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
