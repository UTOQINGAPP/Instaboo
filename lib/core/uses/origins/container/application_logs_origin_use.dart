import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [ApplicationLogsTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [ApplicationLogsTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class ApplicationLogsDriftOriginUse {
  /// Primary key.
  final int id;

  /// Log level.
  final LogLevelEnumDatabase logLevel;

  /// Log message.
  final String logMessage;

  /// Optional context identifier.
  final String? logContext;

  /// Optional reference to installation.
  final int? installationId;

  /// Creation timestamp.
  final DateTime createdAt;

  const ApplicationLogsDriftOriginUse({
    required this.id,
    required this.logLevel,
    required this.logMessage,
    this.logContext,
    this.installationId,
    required this.createdAt,
  });

  /// Builds origin from Drift [ApplicationLogsTableData] (same shape as DB row).
  /// Construye el origen desde [ApplicationLogsTableData] de Drift (misma forma que la fila).
  factory ApplicationLogsDriftOriginUse.fromTableData(
    ApplicationLogsTableData row,
  ) {
    return ApplicationLogsDriftOriginUse(
      id: row.id,
      logLevel: row.logLevel,
      logMessage: row.logMessage,
      logContext: row.logContext,
      installationId: row.installationId,
      createdAt: row.createdAt,
    );
  }
}
