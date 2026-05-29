import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Logs consumer implementation. Delegates to [LogsServiceRule].
/// Implementación del consumer de logs. Delega a [LogsServiceRule].
class LogsConsumerRule {
  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final LogsServiceRule _service;
  /// Constructor.
  /// Constructor.
  LogsConsumerRule({required LogsServiceRule service})
    : _service = service;

  /// Writes a log entry.
  /// Escribe una entrada de log.
  Future<ResponseRule<Unit>> log(
    String message,
    {String level = 'info', String? context, String? referenceId}
  ) {
    return _service.log(message, level: level, context: context, referenceId: referenceId);
  }
  
  /// Writes a debug log entry.
  /// Escribe una entrada de log de depuración.
  Future<ResponseRule<Unit>> logDebug(String message, {String? context}) {
    return _service.logDebug(message, context: context);
  }
  
  /// Writes an info log entry.
  /// Escribe una entrada de log de información.
  Future<ResponseRule<Unit>> logInfo(String message, {String? context}) {
    return _service.logInfo(message, context: context);
  }
  
  /// Writes a warning log entry.
  /// Escribe una entrada de log de advertencia.
  Future<ResponseRule<Unit>> logWarning(String message, {String? context}) {
    return _service.logWarning(message, context: context);
  }
  
  /// Writes an error log entry.
  /// Escribe una entrada de log de error.
  Future<ResponseRule<Unit>> logError(String message, {String? context}) {
    return _service.logError(message, context: context);
  }
  
  // Consulta
  Future<ResponseRule<List<LogDataRule>>> getLogs({
    String? level,
    String? context,
    DateTime? fromDate,
    DateTime? toDate,
    int limit = 100,
  }) {
    return _service.getLogs(level: level, context: context, fromDate: fromDate, toDate: toDate, limit: limit);
  }
  
  /// Returns logs by context.
  /// Devuelve logs por contexto.
  Future<ResponseRule<List<LogDataRule>>> getContextLogs(String context) {
    return _service.getContextLogs(context);
  }
  
  /// Cleans up logs older than a certain number of days.
  /// Elimina logs más antiguos que un cierto número de días.
  Future<ResponseRule<Unit>> cleanup({int? olderThanDays}) {
    return _service.cleanup(olderThanDays: olderThanDays);
  }
}