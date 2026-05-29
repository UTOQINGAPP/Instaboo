import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for setting resolution and persistence.
/// Contrato para resolución y persistencia de configuraciones.
abstract class SettingsServiceRule {
  
  /// Returns a setting by key.
  /// Devuelve una configuración por clave.
  Future<ResponseRule<SettingDataRule>> get(String key);
  
  /// Returns all settings.
  /// Devuelve todas las configuraciones.
  Future<ResponseRule<Map<String, dynamic>>> getAll();
  
  /// Sets a setting.
  /// Establece una configuración.
  Future<ResponseRule<Unit>> set(
    String key,
    dynamic value,
    {String? valueType}
  );
  // valueType: 'string', 'integer', 'boolean', 'json' (auto-detecta si null)
  
  /// Returns an integer setting by key.
  /// Devuelve una configuración entera por clave.
  Future<ResponseRule<int>> getInt(String key);
  /// Returns a boolean setting by key.
  /// Devuelve una configuración booleana por clave.
  Future<ResponseRule<bool>> getBool(String key);
  /// Returns a string setting by key.
  /// Devuelve una configuración de texto por clave.
  Future<ResponseRule<String>> getString(String key);
  
  /// Sets an integer setting.
  /// Establece una configuración entera.
  Future<ResponseRule<Unit>> setInt(String key, int value);
  /// Sets a boolean setting.
  /// Establece una configuración booleana.
  Future<ResponseRule<Unit>> setBool(String key, bool value);
  /// Sets a string setting.
  /// Establece una configuración de texto.
  Future<ResponseRule<Unit>> setString(String key, String value);
  
  /// Resets all settings to their default values.
  /// Reinicia todas las configuraciones a sus valores por defecto.
  Future<ResponseRule<Unit>> resetToDefaults();
}