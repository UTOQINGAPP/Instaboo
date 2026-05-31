import 'package:instaboo/core/rules/enums/enums_rules.dart';

/// Domain representation of the result of an Authenticode signature check.
/// Representación de dominio del resultado de una verificación de firma Authenticode.
final class AuthenticodeCheckDataRule {
  final AuthenticodeCheckStatus status;

  /// Publisher / CN extracted from the signing certificate, when available.
  /// Publisher / CN extraído del certificado firmante, cuando está disponible.
  final String? publisher;

  const AuthenticodeCheckDataRule({
    required this.status,
    this.publisher,
  });

  /// True when the signature is present and trusted.
  bool get isValid => status == AuthenticodeCheckStatus.valid;

  /// True when the file has any signature (even if untrusted).
  bool get isSigned =>
      status == AuthenticodeCheckStatus.valid ||
      status == AuthenticodeCheckStatus.untrusted;
}
