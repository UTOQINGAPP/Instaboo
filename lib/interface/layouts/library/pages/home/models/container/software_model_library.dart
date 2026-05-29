import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

/// UI model for a software row in the library layout.
/// Modelo de UI para una fila de software en el layout de biblioteca.
class SoftwareModelLibrary {
  final int id;
  final String name;
  final String slug;
  final String? version;
  final CategoriesModelShared? category;
  final int? sizeMb;
  final String? description;
  final String? logo;
  final bool isAutoInstallable;
  final InstallerContentTypeEnumRule installerContentType;
  final String installerSource;
  final String? silentArgs;
  final int? minRamGb;
  final int? minDiskGb;
  final String operatingSystem;
  final bool requiresRestart;
  final bool requiresInternet;
  final bool installDependencies;
  final bool backgroundInstall;
  final bool isActive;

  /// Installer framework type id (FK to installer_frameworks).
  /// Id del tipo de framework de instalador.
  final int? installerFrameworkId;

  /// Extra silent args appended on top of framework args.
  /// Args silenciosos extra que se agregan sobre los del framework.
  final String? extraSilentArgs;

  const SoftwareModelLibrary({
    required this.id,
    required this.name,
    required this.slug,
    required this.version,
    this.category,
    required this.sizeMb,
    required this.description,
    required this.logo,
    required this.isAutoInstallable,
    required this.installerContentType,
    required this.installerSource,
    this.silentArgs,
    this.minRamGb,
    this.minDiskGb,
    this.operatingSystem = 'Windows 10+',
    this.requiresRestart = false,
    this.requiresInternet = false,
    this.installDependencies = false,
    this.backgroundInstall = false,
    this.isActive = true,
    this.installerFrameworkId,
    this.extraSilentArgs,
  });
}
