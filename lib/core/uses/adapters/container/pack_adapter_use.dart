import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/pack_origin_use.dart';

/// Adapter between [PackDriftOriginUse] and [InstallationPacksDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [PackDriftOriginUse] y [InstallationPacksDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class PackAdapterUse {
  PackAdapterUse._();

  /// Converts origin to [InstallationPacksDataRule] (domain data).
  /// Convierte origen a [InstallationPacksDataRule] (dato de dominio).
  static InstallationPacksDataRule fromOrigin(PackDriftOriginUse origin) {
    return InstallationPacksDataRule(
      id: origin.id,
      name: origin.name,
      description: origin.description,
      isActive: origin.isActive,
      createdAt: origin.createdAt,
      updatedAt: origin.updatedAt,
    );
  }

  /// Converts [InstallationPacksDataRule] to origin (for use when writing back to DB context).
  /// Convierte [InstallationPacksDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static PackDriftOriginUse toOrigin(InstallationPacksDataRule data) {
    return PackDriftOriginUse(
      id: data.id,
      name: data.name,
      description: data.description,
      isActive: data.isActive,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
