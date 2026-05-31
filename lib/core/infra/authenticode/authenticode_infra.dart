import 'dart:convert';
import 'dart:io';

/// Result of an Authenticode signature check.
/// Resultado de una verificación de firma Authenticode.
enum AuthenticodeStatus {
  /// File is signed and the signature is trusted by the OS.
  valid,

  /// File is signed but the certificate is not trusted / expired / revoked.
  untrusted,

  /// File has no Authenticode signature at all.
  notSigned,

  /// Verification could not be performed (PowerShell unavailable, etc.).
  unknown,
}

/// Information returned by the Authenticode check.
/// Información devuelta por la verificación Authenticode.
final class AuthenticodeResult {
  final AuthenticodeStatus status;

  /// Publisher/subject extracted from the signing certificate, if available.
  final String? publisher;

  /// Human-readable detail message (e.g. error description from PowerShell).
  final String? detail;

  const AuthenticodeResult({
    required this.status,
    this.publisher,
    this.detail,
  });

  bool get isValid => status == AuthenticodeStatus.valid;
  bool get isSigned =>
      status == AuthenticodeStatus.valid ||
      status == AuthenticodeStatus.untrusted;

  @override
  String toString() =>
      'AuthenticodeResult(status: $status, publisher: $publisher)';
}

/// Verifies the Authenticode (digital) signature of a Windows executable
/// using PowerShell's [Get-AuthenticodeSignature] cmdlet.
///
/// Verifica la firma Authenticode de un ejecutable Windows usando el
/// cmdlet [Get-AuthenticodeSignature] de PowerShell.
class AuthenticodeInfra {
  AuthenticodeInfra._();

  static const String _psScript = r'''
param([string]$Path)
try {
  $sig = Get-AuthenticodeSignature -FilePath $Path -ErrorAction Stop
  $pub = if ($sig.SignerCertificate) { $sig.SignerCertificate.Subject } else { $null }
  @{
    Status    = $sig.Status.ToString()
    Publisher = $pub
    Detail    = $sig.StatusMessage
  } | ConvertTo-Json -Compress
} catch {
  @{ Status = 'Unknown'; Publisher = $null; Detail = $_.Exception.Message } |
    ConvertTo-Json -Compress
}
''';

  /// Checks the Authenticode signature of the file at [filePath].
  /// Never throws — returns [AuthenticodeStatus.unknown] on any error.
  ///
  /// Verifica la firma Authenticode del archivo en [filePath].
  /// Nunca lanza excepciones — devuelve [AuthenticodeStatus.unknown] ante cualquier error.
  static Future<AuthenticodeResult> check(String filePath) async {
    try {
      final result = await Process.run(
        'powershell.exe',
        [
          '-NoProfile',
          '-NonInteractive',
          '-Command',
          _psScript,
          '-Path',
          filePath,
        ],
        runInShell: false,
        stdoutEncoding: utf8,
        stderrEncoding: utf8,
      );

      if (result.exitCode != 0) {
        return const AuthenticodeResult(status: AuthenticodeStatus.unknown);
      }

      final raw = (result.stdout as String).trim();
      if (raw.isEmpty) {
        return const AuthenticodeResult(status: AuthenticodeStatus.unknown);
      }

      final Map<String, dynamic> json =
          jsonDecode(raw) as Map<String, dynamic>;
      final statusStr = json['Status']?.toString() ?? '';
      final publisher = _extractCN(json['Publisher']?.toString());
      final detail = json['Detail']?.toString();

      final status = _parseStatus(statusStr);
      return AuthenticodeResult(
        status: status,
        publisher: publisher,
        detail: detail,
      );
    } catch (_) {
      return const AuthenticodeResult(status: AuthenticodeStatus.unknown);
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static AuthenticodeStatus _parseStatus(String s) => switch (s) {
        'Valid' => AuthenticodeStatus.valid,
        'NotSigned' => AuthenticodeStatus.notSigned,
        'UnknownError' ||
        'NotTrusted' ||
        'HashMismatch' ||
        'NotSupportedFileFormat' =>
          AuthenticodeStatus.untrusted,
        _ => AuthenticodeStatus.unknown,
      };

  /// Extracts the CN (Common Name) from a certificate Subject string like
  /// "CN=Publisher Inc, O=..., C=US" → "Publisher Inc".
  static String? _extractCN(String? subject) {
    if (subject == null || subject.isEmpty) return null;
    final match = RegExp(r'CN=([^,]+)').firstMatch(subject);
    return match?.group(1)?.trim();
  }
}
