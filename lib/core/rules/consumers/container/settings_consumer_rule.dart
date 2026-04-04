import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/container/api_response_rule.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

class SettingsConsumerRule {
  final SettingsServiceRule _service;

  SettingsConsumerRule({required SettingsServiceRule service})
    : _service = service;

  @override
  Future<ApiResponseRule<Map<String, dynamic>>> getSystemSettings() {
    return _service.getSystemSettings();
  }

  @override
  Future<ApiResponseRule<UserPreferencesDataRule>> getUserPreferences() {
    return _service.getUserPreferences();
  }

  @override
  Future<ApiResponseRule<Unit>> updateSystemSetting({
    required String key,
    required String value,
  }) {
    return _service.updateSystemSetting(key: key, value: value);
  }

  @override
  Future<ApiResponseRule<Unit>> updateUserPreferences({
    String? installationDirectory,
    int? parallelInstalls,
    bool? runAsAdmin,
    bool? notificationsEnabled,
  }) {
    return _service.updateUserPreferences(
      installationDirectory: installationDirectory,
      parallelInstalls: parallelInstalls,
      runAsAdmin: runAsAdmin,
      notificationsEnabled: notificationsEnabled,
    );
  }
}
