import 'package:instaboo/core/rules/enums/enums_rule.dart';

/// Software data entity for installable applications.
/// Entidad de datos de software para aplicaciones instalables.
///
/// Maps to: software table
/// Mapea a: tabla software
class SoftwareDataRule {
  /// Primary key.
  final int id;

  /// Software name.
  final String name;

  /// Unique slug for URLs/identifiers.
  final String slug;

  /// Version string.
  final String? version;

  /// Foreign key to categories.
  final int categoryId;

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

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const SoftwareDataRule({
    required this.id,
    required this.name,
    required this.slug,
    this.version,
    required this.categoryId,
    this.sizeMb,
    this.description,
    this.logo,
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
    required this.createdAt,
    required this.updatedAt,
  });

  SoftwareDataRule copyWith({
    int? id,
    String? name,
    String? slug,
    String? version,
    int? categoryId,
    int? sizeMb,
    String? description,
    String? logo,
    InstallationTypeEnumRule? installationType,
    InstallerSourceTypeEnumRule? installerSourceType,
    String? installerSource,
    String? silentArgs,
    int? minRamGb,
    int? minDiskGb,
    String? operatingSystem,
    bool? requiresRestart,
    bool? requiresInternet,
    bool? installDependencies,
    bool? backgroundInstall,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SoftwareDataRule(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    version: version ?? this.version,
    categoryId: categoryId ?? this.categoryId,
    sizeMb: sizeMb ?? this.sizeMb,
    description: description ?? this.description,
    logo: logo ?? this.logo,
    installationType: installationType ?? this.installationType,
    installerSourceType: installerSourceType ?? this.installerSourceType,
    installerSource: installerSource ?? this.installerSource,
    silentArgs: silentArgs ?? this.silentArgs,
    minRamGb: minRamGb ?? this.minRamGb,
    minDiskGb: minDiskGb ?? this.minDiskGb,
    operatingSystem: operatingSystem ?? this.operatingSystem,
    requiresRestart: requiresRestart ?? this.requiresRestart,
    requiresInternet: requiresInternet ?? this.requiresInternet,
    installDependencies: installDependencies ?? this.installDependencies,
    backgroundInstall: backgroundInstall ?? this.backgroundInstall,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
