/// Stores the raw output of an Authenticode verification exactly as
/// [AuthenticodeInfra] returns it, without any transformation.
/// Almacena la salida cruda de la verificación Authenticode exactamente
/// como la devuelve AuthenticodeInfra, sin ninguna transformación.
class AuthenticodeOriginUse {
  /// Raw status string from the infra layer (e.g. "Valid", "NotSigned").
  /// Cadena de estado cruda de la capa infra.
  final String statusRaw;

  /// Publisher/CN from the signing certificate, if available.
  /// Publisher/CN del certificado firmante, si está disponible.
  final String? publisher;

  const AuthenticodeOriginUse({
    required this.statusRaw,
    this.publisher,
  });
}
