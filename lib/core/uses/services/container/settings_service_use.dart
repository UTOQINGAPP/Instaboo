import 'package:drift/drift.dart';

import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Settings service use implementation. Delegates to infra (DatabaseInfra).
/// Uses [DatabaseInfra.systemSettingsTable], [DatabaseInfra.userPreferencesTable]
/// and [UserPreferencesAdapterUse] for mapping.
///
/// Implementación del use de servicio de configuración. Delega en infra (DatabaseInfra).
/// Usa [DatabaseInfra.systemSettingsTable], [DatabaseInfra.userPreferencesTable]
/// y [UserPreferencesAdapterUse] para el mapeo.
class SettingsServiceUse implements SettingsServiceRule {
  /// Database infrastructure instance.
  /// Instancia de infraestructura de base de datos.
  final DatabaseInfra _db = DatabaseInfra.instance;

  /// Default profile name for user preferences.
  /// Nombre de perfil por defecto para preferencias de usuario.
  static const String _defaultProfileName = 'default';

  /// Creates the use with optional database instance (for testing).
  /// Crea el use con instancia de base de datos opcional (para pruebas).
  SettingsServiceUse();

  @override
  Future<ApiResponseRule<Map<String, dynamic>>> getSystemSettings() async {
    try {
      final rows = await _db.select(_db.systemSettingsTable).get();
      final map = <String, dynamic>{};
      for (final row in rows) {
        map[row.settingKey] = row.settingValue;
      }
      return SuccessResponseRule(data: map);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_SYSTEM_SETTINGS',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updateSystemSetting({
    required String key,
    required String value,
  }) async {
    try {
      final existing = await (_db.select(_db.systemSettingsTable)
            ..where((t) => t.settingKey.equals(key))
            ..limit(1))
          .getSingleOrNull();
      if (existing != null) {
        await (_db.update(_db.systemSettingsTable)
              ..where((t) => t.id.equals(existing.id)))
            .write(
          SystemSettingsTableCompanion(
            settingValue: Value(value),
            updatedAt: Value(DateTime.now().toUtc()),
          ),
        );
      } else {
        await _db.into(_db.systemSettingsTable).insert(
              SystemSettingsTableCompanion.insert(
                settingKey: key,
                settingValue: Value(value),
              ),
            );
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_SYSTEM_SETTING',
      );
    }
  }

  @override
  Future<ApiResponseRule<UserPreferencesDataRule>> getUserPreferences() async {
    try {
      var rows = await (_db.select(_db.userPreferencesTable)
            ..where((t) => t.profileName.equals(_defaultProfileName)))
          .get();
      if (rows.isEmpty) {
        await _db.into(_db.userPreferencesTable).insert(
              UserPreferencesTableCompanion.insert(
                profileName: const Value(_defaultProfileName),
                installationDirectory: const Value(r'C:\Program Files'),
                parallelInstalls: const Value(2),
                runAsAdmin: const Value(false),
                notificationEnabled: const Value(true),
              ),
            );
        rows = await (_db.select(_db.userPreferencesTable)
              ..where((t) => t.profileName.equals(_defaultProfileName)))
            .get();
      }
      if (rows.isEmpty) {
        return const FailureResponseRule(
          message: 'User preferences not found',
          errorCode: 'NOT_FOUND',
        );
      }
      final data = UserPreferencesAdapterUse.fromOrigin(
        UserPreferencesDriftOriginUse.fromTableData(rows.single),
      );
      return SuccessResponseRule(data: data);
    } catch (e) {
      return FailureResponseRule(
        message: e.toString(),
        errorCode: 'GET_USER_PREFERENCES',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> updateUserPreferences({
    String? installationDirectory,
    int? parallelInstalls,
    bool? runAsAdmin,
    bool? notificationsEnabled,
  }) async {
    try {
      final companion = UserPreferencesTableCompanion(
        installationDirectory: installationDirectory != null
            ? Value(installationDirectory)
            : const Value.absent(),
        parallelInstalls: parallelInstalls != null
            ? Value(parallelInstalls)
            : const Value.absent(),
        runAsAdmin: runAsAdmin != null
            ? Value(runAsAdmin)
            : const Value.absent(),
        notificationEnabled: notificationsEnabled != null
            ? Value(notificationsEnabled)
            : const Value.absent(),
        updatedAt: Value(DateTime.now().toUtc()),
      );
      await (_db.update(_db.userPreferencesTable)
            ..where((t) => t.profileName.equals(_defaultProfileName)))
          .write(companion);
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'UPDATE_USER_PREFERENCES',
      );
    }
  }
}
