import 'dart:convert';

import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps between [SettingOriginUse] and [SettingDataRule].
/// Mapea entre [SettingOriginUse] y [SettingDataRule].
class SettingAdapterUse {
  static SettingDataRule toDataRule(SettingOriginUse origin) =>
      SettingDataRule.fromPersisted(
        key: origin.prefKey,
        value: decodeValue(origin.prefValue, origin.valueType),
        valueType: origin.valueType,
        description: origin.description,
        updatedAt: origin.updatedAt,
      );

  static SettingOriginUse toOriginUse(SettingDataRule data) => SettingOriginUse(
    prefKey: data.key,
    prefValue: encodeValue(data.value, data.valueType),
    valueType: data.valueType,
    description: data.description,
    updatedAt: data.updatedAt,
  );

  /// Parses stored text into a typed value for the domain.
  /// Interpreta el texto almacenado como valor tipado para el dominio.
  static dynamic decodeValue(String? raw, String valueType) {
    switch (valueType) {
      case 'integer':
        return int.tryParse(raw ?? '') ?? 0;
      case 'boolean':
        return raw == '1' || raw == 'true';
      case 'json':
        if (raw == null || raw.isEmpty) {
          return null;
        }
        try {
          return jsonDecode(raw);
        } catch (_) {
          return null;
        }
      case 'string':
      default:
        return raw ?? '';
    }
  }

  /// Serializes a domain value for SQLite text storage.
  /// Serializa un valor de dominio para almacenamiento texto en SQLite.
  static String? encodeValue(dynamic value, String valueType) {
    switch (valueType) {
      case 'integer':
        if (value is int) {
          return value.toString();
        }
        if (value is num) {
          return value.toInt().toString();
        }
        return int.tryParse(value?.toString() ?? '')?.toString() ?? '0';
      case 'boolean':
        if (value is bool) {
          return value ? '1' : '0';
        }
        if (value == 1 || value == '1' || value == 'true') {
          return '1';
        }
        return '0';
      case 'json':
        return jsonEncode(value);
      case 'string':
      default:
        return value?.toString();
    }
  }
}
