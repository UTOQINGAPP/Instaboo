/// Sentinel type for operations that return no data (e.g. delete).
/// Tipo centinela para operaciones que no devuelven datos (ej. delete).
final class Unit {
  const Unit._();
}

/// Single value for [Unit]. Use for success responses with no payload.
/// Valor único de [Unit]. Se usa para respuestas exitosas sin payload.
const unit = Unit._();

/// Core rule that models the result of an operation.
/// Regla del core que modela el resultado de una operación.
///
/// Keeps domain flow explicit with two valid states:
/// Mantiene el flujo del dominio explícito con dos estados válidos:
/// - Success: data is always present.
/// - Failure: message is always present.
abstract class ApiResponseRule<T> {
  const ApiResponseRule();

  /// Whether this response is successful.
  /// Indica si esta respuesta es exitosa.
  bool get isSuccess;

  /// Whether this response is a failure.
  /// Indica si esta respuesta es fallida.
  bool get isFailure => !isSuccess;

  /// Resolves both states in an exhaustive way.
  /// Resuelve ambos estados de forma exhaustiva.
  R resolve<R>({
    required R Function(T data, String? message) onSuccess,
    required R Function(String message, String? errorCode) onFailure,
  });
}

/// Successful response that always contains data.
/// Respuesta exitosa que siempre contiene datos.

class SuccessResponseRule<T> extends ApiResponseRule<T> {
  final T data;
  final String? message;

  const SuccessResponseRule({required this.data, this.message});

  @override
  bool get isSuccess => true;

  @override
  R resolve<R>({
    required R Function(T data, String? message) onSuccess,
    required R Function(String message, String? errorCode) onFailure,
  }) {
    return onSuccess(data, message);
  }
}

/// Failure response that always contains a message.
/// Respuesta fallida que siempre contiene un mensaje.
///
/// Can include an optional error code.
/// Puede incluir un código de error opcional.

class FailureResponseRule<T> extends ApiResponseRule<T> {
  final String message;
  final String? errorCode;

  const FailureResponseRule({required this.message, this.errorCode});

  @override
  bool get isSuccess => false;

  @override
  R resolve<R>({
    required R Function(T data, String? message) onSuccess,
    required R Function(String message, String? errorCode) onFailure,
  }) {
    return onFailure(message, errorCode);
  }
}
