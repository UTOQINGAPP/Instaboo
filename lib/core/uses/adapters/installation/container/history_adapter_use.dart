import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/installation/installation_origins_uses.dart';

/// Maps [HistoryOriginUse] ↔ [HistoryDataRule].
/// Mapea [HistoryOriginUse] ↔ [HistoryDataRule].
class HistoryAdapterUse {
  static HistoryDataRule toDataRule(HistoryOriginUse o) =>
      HistoryDataRule.fromPersisted(
        id: o.id,
        softwareId: o.softwareId,
        packId: o.packId,
        softwareName: o.softwareName,
        softwareVersion: o.softwareVersion,
        installerType: o.installerType,
        status: o.status,
        errorDetails: o.errorDetails,
        startedAt: o.startedAt,
        completedAt: o.completedAt,
        createdAt: o.createdAt,
        machineInfo: o.machineInfo,
      );

  static HistoryOriginUse toOriginUse(HistoryDataRule d) => HistoryOriginUse(
    id: d.id,
    softwareId: d.softwareId,
    packId: d.packId,
    softwareName: d.softwareName,
    softwareVersion: d.softwareVersion,
    installerType: d.installerType,
    status: d.status,
    errorDetails: d.errorDetails,
    startedAt: d.startedAt,
    completedAt: d.completedAt,
    createdAt: d.createdAt,
    machineInfo: d.machineInfo,
  );
}
