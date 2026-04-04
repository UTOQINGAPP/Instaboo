import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/application_logs_origin_use.dart';

/// Adapter between [ApplicationLogsDriftOriginUse] and [ApplicationLogsDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [ApplicationLogsDriftOriginUse] y [ApplicationLogsDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class ApplicationLogsAdapterUse {
  ApplicationLogsAdapterUse._();

  /// Converts origin to [ApplicationLogsDataRule] (domain data).
  /// Convierte origen a [ApplicationLogsDataRule] (dato de dominio).
  static ApplicationLogsDataRule fromOrigin(
    ApplicationLogsDriftOriginUse origin,
  ) {
    return ApplicationLogsDataRule(
      id: origin.id,
      logLevel: LogLevelEnumRule.values.byName(origin.logLevel.name),
      logMessage: origin.logMessage,
      logContext: origin.logContext,
      installationId: origin.installationId,
      createdAt: origin.createdAt,
    );
  }

  /// Converts [ApplicationLogsDataRule] to origin (for use when writing back to DB context).
  /// Convierte [ApplicationLogsDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static ApplicationLogsDriftOriginUse toOrigin(
    ApplicationLogsDataRule data,
  ) {
    return ApplicationLogsDriftOriginUse(
      id: data.id,
      logLevel: LogLevelEnumDatabase.values.byName(data.logLevel.name),
      logMessage: data.logMessage,
      logContext: data.logContext,
      installationId: data.installationId,
      createdAt: data.createdAt,
    );
  }
}
