/// Clean status of a Windows Authenticode signature check.
/// Estado limpio del resultado de una verificación Authenticode de Windows.
enum AuthenticodeCheckStatus {
  /// File is signed and the signature is trusted by the OS.
  valid,

  /// File is signed but the certificate is not trusted / expired / revoked.
  untrusted,

  /// File has no Authenticode signature at all.
  notSigned,

  /// Verification could not be performed.
  unknown,
}
