import 'package:drift/drift.dart';

/// User preferences (local desktop app profile).
/// Preferencias de usuario (perfil de aplicación de escritorio local).
///
/// Maps to PostgreSQL: user_preferences
/// Mapea a PostgreSQL: user_preferences
class UserPreferencesTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Profile name (unique, default: 'default').
  TextColumn get profileName =>
      text().withLength(max: 100).unique().withDefault(const Constant('default'))();

  /// Installation directory path.
  TextColumn get installationDirectory =>
      text().withLength(max: 500).withDefault(const Constant(r'C:\Program Files'))();

  /// Number of parallel installations allowed.
  IntColumn get parallelInstalls => integer().withDefault(const Constant(2))();

  /// Whether to run installations as admin.
  BoolColumn get runAsAdmin => boolean().withDefault(const Constant(false))();

  /// Whether notifications are enabled.
  BoolColumn get notificationEnabled => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
