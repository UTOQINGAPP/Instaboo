import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/installation_origin_use.dart';

/// Adapter between [InstallationDriftOriginUse] and [InstallationsDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [InstallationDriftOriginUse] y [InstallationsDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class InstallationAdapterUse {
  InstallationAdapterUse._();

  /// Converts origin to [InstallationsDataRule] (domain data).
  /// Convierte origen a [InstallationsDataRule] (dato de dominio).
  static InstallationsDataRule fromOrigin(
    InstallationDriftOriginUse origin,
  ) {
    return InstallationsDataRule(
      id: origin.id,
      sourceType: InstallationSourceTypeEnumRule.values.byName(
        origin.sourceType.name,
      ),
      softwareId: origin.softwareId,
      packId: origin.packId,
      displayName: origin.displayName,
      status: InstallationStatusEnumRule.values.byName(origin.status.name),
      progress: origin.progress,
      queuePosition: origin.queuePosition,
      startedAt: origin.startedAt,
      completedAt: origin.completedAt,
      errorMessage: origin.errorMessage,
      createdAt: origin.createdAt,
      updatedAt: origin.updatedAt,
    );
  }

  /// Converts [InstallationsDataRule] to origin (for use when writing back to DB context).
  /// Convierte [InstallationsDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static InstallationDriftOriginUse toOrigin(InstallationsDataRule data) {
    return InstallationDriftOriginUse(
      id: data.id,
      sourceType: InstallationSourceTypeEnumDatabase.values.byName(
        data.sourceType.name,
      ),
      softwareId: data.softwareId,
      packId: data.packId,
      displayName: data.displayName,
      status: InstallationStatusEnumDatabase.values.byName(data.status.name),
      progress: data.progress,
      queuePosition: data.queuePosition,
      startedAt: data.startedAt,
      completedAt: data.completedAt,
      errorMessage: data.errorMessage,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
