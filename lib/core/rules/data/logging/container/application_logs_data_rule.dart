import 'package:instaboo/core/rules/enums/enums_rule.dart';

/// Application log data entity for debugging and auditing.
/// Entidad de datos de log de aplicación para depuración y auditoría.
///
/// Maps to: application_logs table
/// Mapea a: tabla application_logs
class ApplicationLogsDataRule {
  /// Primary key.
  final int id;

  /// Log level.
  final LogLevelEnumRule logLevel;

  /// Log message.
  final String logMessage;

  /// Optional context identifier.
  final String? logContext;

  /// Optional reference to installation.
  final int? installationId;

  /// Creation timestamp.
  final DateTime createdAt;

  const ApplicationLogsDataRule({
    required this.id,
    this.logLevel = LogLevelEnumRule.info,
    required this.logMessage,
    this.logContext,
    this.installationId,
    required this.createdAt,
  });

  ApplicationLogsDataRule copyWith({
    int? id,
    LogLevelEnumRule? logLevel,
    String? logMessage,
    String? logContext,
    int? installationId,
    DateTime? createdAt,
  }) => ApplicationLogsDataRule(
    id: id ?? this.id,
    logLevel: logLevel ?? this.logLevel,
    logMessage: logMessage ?? this.logMessage,
    logContext: logContext ?? this.logContext,
    installationId: installationId ?? this.installationId,
    createdAt: createdAt ?? this.createdAt,
  );
}
