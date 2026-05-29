import 'package:instaboo/core/infra/infra_core.dart';

/// Raw log row from Drift.
/// Fila de log cruda desde Drift.
class LogOriginUse {
  final int id;
  final String level;
  final String message;
  final String? context;
  final String? referenceId;
  final DateTime createdAt;

  const LogOriginUse({
    required this.id,
    required this.level,
    required this.message,
    this.context,
    this.referenceId,
    required this.createdAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory LogOriginUse.fromDrift(LogsTableData row) => LogOriginUse(
        id: row.id,
        level: row.level,
        message: row.message,
        context: row.context,
        referenceId: row.referenceId,
        createdAt: row.createdAt,
      );
}
