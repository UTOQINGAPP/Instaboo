import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Settings consumer implementation. Delegates to [SettingsServiceRule].
/// Implementación del consumer de configuraciones. Delega a [SettingsServiceRule].
class SettingsConsumerRule {

  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final SettingsServiceRule _service;
  
  /// Constructor.
  /// Constructor.
  SettingsConsumerRule({required SettingsServiceRule service})
    : _service = service;

  /// Returns a setting by key.
  /// Devuelve una configuración por clave.
  Future<ResponseRule<SettingDataRule>> get(String key) {
    return _service.get(key);
  }
  
  /// Returns all settings.
  /// Devuelve todas las configuraciones.
  Future<ResponseRule<Map<String, dynamic>>> getAll() {
    return _service.getAll();
  }
  
  /// Sets a setting.
  /// Establece una configuración.
  Future<ResponseRule<Unit>> set(
    String key,
    dynamic value,
    {String? valueType}
  ) {
    return _service.set(key, value, valueType: valueType);
  }
  // valueType: 'string', 'integer', 'boolean', 'json' (auto-detecta si null)
  
  /// Returns an integer setting by key.
  /// Devuelve una configuración entera por clave.
  Future<ResponseRule<int>> getInt(String key) {
    return _service.getInt(key);
  }
  /// Returns a boolean setting by key.
  /// Devuelve una configuración booleana por clave.
  Future<ResponseRule<bool>> getBool(String key) {
    return _service.getBool(key);
  }
  /// Returns a string setting by key.
  /// Devuelve una configuración de texto por clave.
  Future<ResponseRule<String>> getString(String key) {
    return _service.getString(key);
  }
  
  /// Sets an integer setting.
  /// Establece una configuración entera.
  Future<ResponseRule<Unit>> setInt(String key, int value) {
    return _service.setInt(key, value);
  }
  /// Sets a boolean setting.
  /// Establece una configuración booleana.
  Future<ResponseRule<Unit>> setBool(String key, bool value) {
    return _service.setBool(key, value);
  }
  /// Sets a string setting.
  /// Establece una configuración de texto.
  Future<ResponseRule<Unit>> setString(String key, String value) {
    return _service.setString(key, value);
  }
  
  /// Resets all settings to their default values.
  /// Reinicia todas las configuraciones a sus valores por defecto.
  Future<ResponseRule<Unit>> resetToDefaults() {
    return _service.resetToDefaults();
  }
}