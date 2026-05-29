import 'package:drift/drift.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/adapters/adapters_uses.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Persists settings in SQLite; uses origin and adapter when exposing [SettingDataRule].
/// Persiste configuración en SQLite; usa origen y adaptador al exponer [SettingDataRule].
class SettingsServiceUse implements SettingsServiceRule {
  final AppDatabaseInfra _database = AppDatabaseInfra.instance;

  /// Default rows (must match [AppDatabaseInfra] migration v1 seed).
  /// Filas por defecto (deben coincidir con la semilla v1 de [AppDatabaseInfra]).
  static List<SettingsTableCompanion> _defaultSettingInserts() => [
        SettingsTableCompanion.insert(
          prefKey: 'parallel_installs',
          prefValue: const Value('2'),
          valueType: const Value('integer'),
          description: const Value(
            'Allowed concurrent installs. / Instalaciones simultáneas permitidas.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'run_as_admin',
          prefValue: const Value('0'),
          valueType: const Value('boolean'),
          description: const Value(
            'Run installers elevated. / Ejecutar instaladores como administrador.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'notifications_enabled',
          prefValue: const Value('1'),
          valueType: const Value('boolean'),
          description: const Value(
            'System notifications. / Mostrar notificaciones del sistema.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'theme',
          prefValue: const Value('system'),
          valueType: const Value('string'),
          description: const Value(
            'UI theme: system, light, dark. / Tema visual: system, light, dark.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'language',
          prefValue: const Value('es'),
          valueType: const Value('string'),
          description: const Value(
            'Interface language. / Idioma de la interfaz.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'auto_verify_on_startup',
          prefValue: const Value('1'),
          valueType: const Value('boolean'),
          description: const Value(
            'Verify installers on startup. / Verificar instaladores al iniciar.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'max_log_days',
          prefValue: const Value('30'),
          valueType: const Value('integer'),
          description: const Value(
            'Log retention in days. / Días de retención de logs.',
          ),
        ),
        SettingsTableCompanion.insert(
          prefKey: 'default_silent_args',
          prefValue: const Value(''),
          valueType: const Value('string'),
          description: const Value(
            'Default silent install arguments applied to all software when no specific args are set. / Argumentos silenciosos por defecto aplicados a todo el software cuando no se especifican args propios.',
          ),
        ),
      ];

  SettingDataRule _dataRuleFromRow(SettingsTableData row) =>
      SettingAdapterUse.toDataRule(SettingOriginUse.fromDrift(row));

  String _resolveValueType(dynamic value, String? hint) {
    if (hint != null && hint.isNotEmpty) {
      return hint;
    }
    if (value is int) {
      return 'integer';
    }
    if (value is bool) {
      return 'boolean';
    }
    if (value is String) {
      return 'string';
    }
    if (value is Map || value is List) {
      return 'json';
    }
    return 'string';
  }

  @override
  Future<ResponseRule<SettingDataRule>> get(String key) async {
    try {
      final row = await (_database.select(_database.settingsTable)
            ..where((t) => t.prefKey.equals(key)))
          .getSingleOrNull();
      if (row == null) {
        return const FailureResponseRule(message: 'Setting not found.');
      }
      return SuccessResponseRule(data: _dataRuleFromRow(row));
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Map<String, dynamic>>> getAll() async {
    try {
      final rows = await _database.select(_database.settingsTable).get();
      final map = <String, dynamic>{};
      for (final row in rows) {
        map[row.prefKey] =
            SettingAdapterUse.decodeValue(row.prefValue, row.valueType);
      }
      return SuccessResponseRule(data: map);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<bool>> getBool(String key) async {
    final r = await get(key);
    return r.resolve(
      onSuccess: (data, _) {
        final v = data.value;
        if (v is bool) {
          return SuccessResponseRule(data: v);
        }
        if (v == 1 || v == '1' || v == 'true') {
          return const SuccessResponseRule(data: true);
        }
        if (v == 0 || v == '0' || v == 'false') {
          return const SuccessResponseRule(data: false);
        }
        return const FailureResponseRule<bool>(
          message: 'Setting is not a boolean.',
        );
      },
      onFailure: (message, code) =>
          FailureResponseRule<bool>(message: message, errorCode: code),
    );
  }

  @override
  Future<ResponseRule<int>> getInt(String key) async {
    final r = await get(key);
    return r.resolve(
      onSuccess: (data, _) {
        final v = data.value;
        if (v is int) {
          return SuccessResponseRule(data: v);
        }
        final p = int.tryParse(v.toString());
        if (p != null) {
          return SuccessResponseRule(data: p);
        }
        return const FailureResponseRule<int>(
          message: 'Setting is not an integer.',
        );
      },
      onFailure: (message, code) =>
          FailureResponseRule<int>(message: message, errorCode: code),
    );
  }

  @override
  Future<ResponseRule<String>> getString(String key) async {
    final r = await get(key);
    return r.resolve(
      onSuccess: (data, _) =>
          SuccessResponseRule(data: data.value?.toString() ?? ''),
      onFailure: (message, code) =>
          FailureResponseRule<String>(message: message, errorCode: code),
    );
  }

  @override
  Future<ResponseRule<Unit>> resetToDefaults() async {
    try {
      await _database.delete(_database.settingsTable).go();
      await _database.batch((b) {
        b.insertAll(_database.settingsTable, _defaultSettingInserts());
      });
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> set(
    String key,
    dynamic value, {
    String? valueType,
  }) async {
    try {
      final type = _resolveValueType(value, valueType);
      final serialized = SettingAdapterUse.encodeValue(value, type) ?? '';
      final companion = SettingsTableCompanion(
        prefValue: Value(serialized),
        valueType: Value(type),
        updatedAt: Value(DateTime.now()),
      );
      final n = await (_database.update(_database.settingsTable)
            ..where((t) => t.prefKey.equals(key)))
          .write(companion);
      if (n == 0) {
        await _database.into(_database.settingsTable).insert(
              SettingsTableCompanion.insert(
                prefKey: key,
                prefValue: Value(serialized),
                valueType: Value(type),
              ),
            );
      }
      return const SuccessResponseRule(data: unit);
    } catch (e) {
      return FailureResponseRule(message: e.toString());
    }
  }

  @override
  Future<ResponseRule<Unit>> setBool(String key, bool value) async {
    return set(key, value, valueType: 'boolean');
  }

  @override
  Future<ResponseRule<Unit>> setInt(String key, int value) async {
    return set(key, value, valueType: 'integer');
  }

  @override
  Future<ResponseRule<Unit>> setString(String key, String value) async {
    return set(key, value, valueType: 'string');
  }
}
