import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';

abstract class SettingsServiceRule {
  /// Returns all system settings.
  /// Devuelve todas las configuraciones del sistema.
  Future<ApiResponseRule<Map<String, dynamic>>> getSystemSettings();

  /// Updates a system setting.
  /// Actualiza una configuración del sistema.
  Future<ApiResponseRule<Unit>> updateSystemSetting({
    required String key,
    required String value,
  });

  /// Returns user preferences.
  /// Devuelve las preferencias del usuario.
  Future<ApiResponseRule<UserPreferencesDataRule>> getUserPreferences();

  /// Updates user preferences.
  /// Actualiza las preferencias del usuario.
  Future<ApiResponseRule<Unit>> updateUserPreferences({
    String? installationDirectory,
    int? parallelInstalls,
    bool? runAsAdmin,
    bool? notificationsEnabled,
  });
}
