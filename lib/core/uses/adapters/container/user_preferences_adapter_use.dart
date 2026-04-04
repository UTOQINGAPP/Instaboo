import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/user_preferences_origin_use.dart';

/// Adapter between [UserPreferencesDriftOriginUse] and [UserPreferencesDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [UserPreferencesDriftOriginUse] y [UserPreferencesDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class UserPreferencesAdapterUse {
  UserPreferencesAdapterUse._();

  /// Converts origin to [UserPreferencesDataRule] (domain data).
  /// Convierte origen a [UserPreferencesDataRule] (dato de dominio).
  static UserPreferencesDataRule fromOrigin(
    UserPreferencesDriftOriginUse origin,
  ) {
    return UserPreferencesDataRule(
      id: origin.id,
      profileName: origin.profileName,
      installationDirectory: origin.installationDirectory,
      parallelInstalls: origin.parallelInstalls,
      runAsAdmin: origin.runAsAdmin,
      notificationEnabled: origin.notificationEnabled,
      createdAt: origin.createdAt,
      updatedAt: origin.updatedAt,
    );
  }

  /// Converts [UserPreferencesDataRule] to origin (for use when writing back to DB context).
  /// Convierte [UserPreferencesDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static UserPreferencesDriftOriginUse toOrigin(
    UserPreferencesDataRule data,
  ) {
    return UserPreferencesDriftOriginUse(
      id: data.id,
      profileName: data.profileName,
      installationDirectory: data.installationDirectory,
      parallelInstalls: data.parallelInstalls,
      runAsAdmin: data.runAsAdmin,
      notificationEnabled: data.notificationEnabled,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
