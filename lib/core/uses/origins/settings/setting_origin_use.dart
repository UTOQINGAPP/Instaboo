import 'package:instaboo/core/infra/infra_core.dart';

/// Raw setting row as read from SQLite (Drift).
/// Fila de configuración cruda leída de SQLite (Drift).
class SettingOriginUse {
  /// Setting key. / Clave de configuración.
  final String prefKey;

  /// Serialized value in storage. / Valor serializado en almacenamiento.
  final String? prefValue;

  /// `string`, `integer`, `boolean`, or `json`. / Tipo almacenado.
  final String valueType;

  /// Optional description. / Descripción opcional.
  final String? description;

  /// Last update time. / Última actualización.
  final DateTime updatedAt;

  const SettingOriginUse({
    required this.prefKey,
    this.prefValue,
    required this.valueType,
    this.description,
    required this.updatedAt,
  });

  /// Builds the origin from Drift row data.
  /// Construye el origen desde la fila Drift.
  factory SettingOriginUse.fromDrift(SettingsTableData row) => SettingOriginUse(
        prefKey: row.prefKey,
        prefValue: row.prefValue,
        valueType: row.valueType,
        description: row.description,
        updatedAt: row.updatedAt,
      );
}
