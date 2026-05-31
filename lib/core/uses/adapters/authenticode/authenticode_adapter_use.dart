import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Converts an [AuthenticodeOriginUse] into an [AuthenticodeCheckDataRule].
/// No state, no business decisions — pure transformation.
/// Convierte un [AuthenticodeOriginUse] en un [AuthenticodeCheckDataRule].
/// Sin estado ni lógica de negocio — transformación pura.
class AuthenticodeAdapterUse {
  static AuthenticodeCheckDataRule toDataRule(AuthenticodeOriginUse origin) {
    final status = _parseStatus(origin.statusRaw);
    return AuthenticodeCheckDataRule(
      status: status,
      publisher: origin.publisher,
    );
  }

  static AuthenticodeCheckStatus _parseStatus(String raw) => switch (raw) {
        'Valid' => AuthenticodeCheckStatus.valid,
        'NotSigned' => AuthenticodeCheckStatus.notSigned,
        'UnknownError' ||
        'NotTrusted' ||
        'HashMismatch' ||
        'NotSupportedFileFormat' =>
          AuthenticodeCheckStatus.untrusted,
        _ => AuthenticodeCheckStatus.unknown,
      };
}
