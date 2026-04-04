import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/installation_history_origin_use.dart';

/// Adapter between [InstallationHistoryDriftOriginUse] and [InstallationHistoryDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [InstallationHistoryDriftOriginUse] y [InstallationHistoryDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class InstallationHistoryAdapterUse {
  InstallationHistoryAdapterUse._();

  /// Converts origin to [InstallationHistoryDataRule] (domain data).
  /// Convierte origen a [InstallationHistoryDataRule] (dato de dominio).
  static InstallationHistoryDataRule fromOrigin(
    InstallationHistoryDriftOriginUse origin,
  ) {
    return InstallationHistoryDataRule(
      id: origin.id,
      installationId: origin.installationId,
      softwareId: origin.softwareId,
      softwareName: origin.softwareName,
      installationDate: origin.installationDate,
      status: HistoryStatusEnumRule.values.byName(origin.status.name),
      durationSeconds: origin.durationSeconds,
      errorDetails: origin.errorDetails,
      createdAt: origin.createdAt,
    );
  }

  /// Converts [InstallationHistoryDataRule] to origin (for use when writing back to DB context).
  /// Convierte [InstallationHistoryDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static InstallationHistoryDriftOriginUse toOrigin(
    InstallationHistoryDataRule data,
  ) {
    return InstallationHistoryDriftOriginUse(
      id: data.id,
      installationId: data.installationId,
      softwareId: data.softwareId,
      softwareName: data.softwareName,
      installationDate: data.installationDate,
      status: HistoryStatusEnumDatabase.values.byName(data.status.name),
      durationSeconds: data.durationSeconds,
      errorDetails: data.errorDetails,
      createdAt: data.createdAt,
    );
  }
}
