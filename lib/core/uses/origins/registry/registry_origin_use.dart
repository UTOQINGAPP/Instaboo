/// Stores a raw entry from the Windows uninstall registry exactly as
/// PowerShell returns it, without any transformation.
/// Almacena una entrada cruda del registro de desinstalación de Windows
/// exactamente como la devuelve PowerShell, sin ninguna transformación.
class RegistryOriginUse {
  final String displayName;
  final String? displayVersion;
  final String? publisher;

  const RegistryOriginUse({
    required this.displayName,
    this.displayVersion,
    this.publisher,
  });

  /// Builds the origin from the raw [Map] returned by [WindowsRegistryInfra].
  factory RegistryOriginUse.fromMap(Map<String, dynamic> map) {
    return RegistryOriginUse(
      displayName: map['DisplayName'].toString().trim(),
      displayVersion: map['DisplayVersion']?.toString().trim(),
      publisher: map['Publisher']?.toString().trim(),
    );
  }
}
