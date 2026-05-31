/// Information about a program found in the Windows uninstall registry.
/// Información sobre un programa encontrado en el registro de desinstalación de Windows.
final class InstalledSoftwareInfoRule {
  final String displayName;
  final String? displayVersion;
  final String? publisher;

  const InstalledSoftwareInfoRule({
    required this.displayName,
    this.displayVersion,
    this.publisher,
  });

  @override
  String toString() =>
      'InstalledSoftwareInfoRule(displayName: $displayName, '
      'displayVersion: $displayVersion, publisher: $publisher)';
}
