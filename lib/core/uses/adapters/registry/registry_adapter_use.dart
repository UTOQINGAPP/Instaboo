import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Converts a [RegistryOriginUse] to an [InstalledSoftwareInfoRule].
/// Has no state and takes no business decisions — pure transformation.
/// Convierte un [RegistryOriginUse] en un [InstalledSoftwareInfoRule].
/// Sin estado ni lógica de negocio — transformación pura.
class RegistryAdapterUse {
  static InstalledSoftwareInfoRule toDataRule(RegistryOriginUse origin) =>
      InstalledSoftwareInfoRule(
        displayName: origin.displayName,
        displayVersion: origin.displayVersion,
        publisher: origin.publisher,
      );
}
