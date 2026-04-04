/// User preferences data entity (local desktop app profile).
/// Entidad de datos de preferencias de usuario (perfil de app de escritorio).
///
/// Maps to: user_preferences table
/// Mapea a: tabla user_preferences
class UserPreferencesDataRule {
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

  const UserPreferencesDataRule({
    required this.id,
    this.profileName = 'default',
    this.installationDirectory = r'C:\Program Files',
    this.parallelInstalls = 2,
    this.runAsAdmin = false,
    this.notificationEnabled = true,
    required this.createdAt,
    required this.updatedAt,
  });

  UserPreferencesDataRule copyWith({
    int? id,
    String? profileName,
    String? installationDirectory,
    int? parallelInstalls,
    bool? runAsAdmin,
    bool? notificationEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserPreferencesDataRule(
    id: id ?? this.id,
    profileName: profileName ?? this.profileName,
    installationDirectory: installationDirectory ?? this.installationDirectory,
    parallelInstalls: parallelInstalls ?? this.parallelInstalls,
    runAsAdmin: runAsAdmin ?? this.runAsAdmin,
    notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
