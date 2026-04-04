import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [UserPreferencesTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [UserPreferencesTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class UserPreferencesDriftOriginUse {
  /// Primary key.
  final int id;

  /// Profile name (unique, default: 'default').
  final String profileName;

  /// Installation directory path.
  final String installationDirectory;

  /// Number of parallel installations allowed.
  final int parallelInstalls;

  /// Whether to run installations as admin.
  final bool runAsAdmin;

  /// Whether notifications are enabled.
  final bool notificationEnabled;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const UserPreferencesDriftOriginUse({
    required this.id,
    required this.profileName,
    required this.installationDirectory,
    required this.parallelInstalls,
    required this.runAsAdmin,
    required this.notificationEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Builds origin from Drift [UserPreferencesTableData] (same shape as DB row).
  /// Construye el origen desde [UserPreferencesTableData] de Drift (misma forma que la fila).
  factory UserPreferencesDriftOriginUse.fromTableData(
    UserPreferencesTableData row,
  ) {
    return UserPreferencesDriftOriginUse(
      id: row.id,
      profileName: row.profileName,
      installationDirectory: row.installationDirectory,
      parallelInstalls: row.parallelInstalls,
      runAsAdmin: row.runAsAdmin,
      notificationEnabled: row.notificationEnabled,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
