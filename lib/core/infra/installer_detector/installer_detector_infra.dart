import 'dart:io';
import 'dart:typed_data';

/// Known installer framework names matched by binary signatures.
/// Nombres de frameworks conocidos detectados por firmas binarias.
///
/// These strings map directly to the `name` column in installer_frameworks DB table.
/// Estos strings corresponden directamente a la columna `name` en la tabla installer_frameworks.
abstract final class InstallerFrameworkNames {
  static const String nsis = 'NSIS';
  static const String innoSetup = 'Inno Setup';
  static const String msi = 'MSI / Windows Installer';
  static const String installShield = 'InstallShield';
  static const String squirrel = 'Squirrel';
  static const String qtIfw = 'Qt Installer Framework';
  static const String sfx = '7-Zip SFX / WinRAR SFX';
  static const String generic = 'Generic / Other';
}

/// Detects the installer framework used by a Windows executable by scanning
/// its binary content for known byte-string signatures.
///
/// Detecta el framework de instalador de un ejecutable Windows escaneando
/// su contenido binario en busca de firmas de bytes conocidas.
class InstallerDetectorInfra {
  InstallerDetectorInfra._();

  /// Returns the matched framework name or null if no signature is found.
  /// Devuelve el nombre del framework o null si no se encuentra firma.
  static Future<String?> detect(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return null;

    // .msi files are COM Structured Storage – detect by magic bytes.
    // Los archivos .msi son COM Structured Storage – detectar por magic bytes.
    final ext = filePath.toLowerCase().split('.').last;
    if (ext == 'msi' || ext == 'msix') {
      return InstallerFrameworkNames.msi;
    }

    // Read up to 1 MB for signature scanning (most signatures are in first 512 KB).
    // Leer hasta 1 MB para escaneo de firmas (la mayoría están en los primeros 512 KB).
    final length = await file.length();
    final readLength = length < 1024 * 1024 ? length : 1024 * 1024;
    final Uint8List bytes =
        await file.openRead(0, readLength).expand((c) => c).toList().then(
              (list) => Uint8List.fromList(list),
            );

    final content = String.fromCharCodes(bytes, 0, bytes.length);

    // Priority order matters: more specific signatures first.
    // El orden de prioridad importa: firmas más específicas primero.

    if (_contains(content, 'Inno Setup')) {
      return InstallerFrameworkNames.innoSetup;
    }
    if (_contains(content, 'Nullsoft.NSIS') ||
        _contains(content, 'Nullsoft Install System') ||
        _contains(content, 'NSIS Error')) {
      return InstallerFrameworkNames.nsis;
    }
    if (_contains(content, 'InstallShield')) {
      return InstallerFrameworkNames.installShield;
    }
    if (_contains(content, 'squirrel.exe') ||
        _contains(content, 'Squirrel.exe') ||
        _contains(content, 'SquirrelSetup')) {
      return InstallerFrameworkNames.squirrel;
    }
    if (_contains(content, 'Qt Installer Framework') ||
        _contains(content, 'IFW ') ||
        _contains(content, 'installerbase')) {
      return InstallerFrameworkNames.qtIfw;
    }
    // 7-Zip SFX / WinRAR SFX
    if (_contains(content, '7-Zip') || _contains(content, 'WinRAR SFX')) {
      return InstallerFrameworkNames.sfx;
    }
    // MSI wrapper by magic bytes D0 CF 11 E0 (COM signature)
    if (bytes.length >= 4 &&
        bytes[0] == 0xD0 &&
        bytes[1] == 0xCF &&
        bytes[2] == 0x11 &&
        bytes[3] == 0xE0) {
      return InstallerFrameworkNames.msi;
    }
    // Check for generic NSIS /S flag mention in strings
    if (_contains(content, 'Nullsoft')) {
      return InstallerFrameworkNames.nsis;
    }

    return null; // Unknown – let user choose manually.
  }

  static bool _contains(String content, String signature) =>
      content.contains(signature);
}
