import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

class SoftwareModelLibrary {
  /// Primary key.
  final int id;

  /// Software name.
  final String name;

  /// Unique slug for URLs/identifiers.
  final String slug;

  /// Version string.
  final String? version;

  /// Category associated with this software (nullable when not resolved).
  /// Categoría asociada a este software (puede ser null si no está resuelta).
  final CategoriesModelShared? category;

  /// Size in MB (nullable).
  final int? sizeMb;

  /// Description text.
  final String? description;

  /// Logo path or URL.
  final String? logo;

  /// Installation type: auto or assisted.
  final InstallationTypeEnumRule installationType;

  /// Installer source type.
  final InstallerSourceTypeEnumRule installerSourceType;

  /// Installer source (path, URL, command, etc.).
  final String installerSource;

  /// Silent installation arguments.
  final String? silentArgs;

  /// Minimum RAM in GB.
  final int? minRamGb;

  /// Minimum disk space in GB.
  final int? minDiskGb;

  /// Operating system requirement.
  final String operatingSystem;

  /// Whether installation requires restart.
  final bool requiresRestart;

  /// Whether installation requires internet.
  final bool requiresInternet;

  /// Whether to install dependencies.
  final bool installDependencies;

  /// Whether to run installation in background.
  final bool backgroundInstall;

  /// Whether the software entry is active.
  final bool isActive;

  const SoftwareModelLibrary({
    required this.id,
    required this.name,
    required this.slug,
    required this.version,
    this.category,
    required this.sizeMb,
    required this.description,
    required this.logo,
    required this.installationType,
    required this.installerSourceType,
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
  });
}
