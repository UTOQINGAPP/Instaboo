import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for log resolution and persistence.
/// Contrato para resolución y persistencia de logs.
abstract class LogsServiceRule {
  
  /// Writes a log entry.
  /// Escribe una entrada de log.
  Future<ResponseRule<Unit>> log(
    String message,
    {String level = 'info', String? context, String? referenceId}
  );
  
  /// Writes a debug log entry.
  /// Escribe una entrada de log de depuración.
  Future<ResponseRule<Unit>> logDebug(String message, {String? context});
  
  /// Writes an info log entry.
  /// Escribe una entrada de log de información.
  Future<ResponseRule<Unit>> logInfo(String message, {String? context});
  
  /// Writes a warning log entry.
  /// Escribe una entrada de log de advertencia.
  Future<ResponseRule<Unit>> logWarning(String message, {String? context});
  
  /// Writes an error log entry.
  /// Escribe una entrada de log de error.
  Future<ResponseRule<Unit>> logError(String message, {String? context});
  
  // Consulta
  Future<ResponseRule<List<LogDataRule>>> getLogs({
    String? level,
    String? context,
    DateTime? fromDate,
    DateTime? toDate,
    int limit = 100,
  });
  
  /// Returns logs by context.
  /// Devuelve logs por contexto.
  Future<ResponseRule<List<LogDataRule>>> getContextLogs(String context);
  
  /// Cleans up logs older than a certain number of days.
  /// Elimina logs más antiguos que un cierto número de días.
  Future<ResponseRule<Unit>> cleanup({int? olderThanDays});
}