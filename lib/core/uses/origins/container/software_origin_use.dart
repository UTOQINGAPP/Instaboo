import 'package:instaboo/core/infra/infra_core.dart';

/// Origin type that mirrors Drift [SoftwareTableData] 1:1.
/// Used as the intermediate representation between DB and rules.
///
/// Tipo origen que replica [SoftwareTableData] de Drift 1:1.
/// Se usa como representación intermedia entre DB y rules.
class SoftwareDriftOriginUse {
  final int id;
  final String name;
  final String slug;
  final String? version;
  final int categoryId;
  final int? sizeMb;
  final String? description;
  final String? logo;
  final InstallationTypeEnumDatabase installationType;
  final InstallerSourceTypeEnumDatabase installerSourceType;
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
  final DateTime createdAt;
  final DateTime updatedAt;

  const SoftwareDriftOriginUse({
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

  /// Builds origin from Drift [SoftwareTableData] (same shape as DB row).
  /// Construye el origen desde [SoftwareTableData] de Drift (misma forma que la fila).
  factory SoftwareDriftOriginUse.fromTableData(SoftwareTableData row) {
    return SoftwareDriftOriginUse(
      id: row.id,
      name: row.name,
      slug: row.slug,
      version: row.version,
      categoryId: row.categoryId,
      sizeMb: row.sizeMb,
      description: row.description,
      logo: row.logo,
      installationType: row.installationType,
      installerSourceType: row.installerSourceType,
      installerSource: row.installerSource,
      silentArgs: row.silentArgs,
      minRamGb: row.minRamGb,
      minDiskGb: row.minDiskGb,
      operatingSystem: row.operatingSystem,
      requiresRestart: row.requiresRestart,
      requiresInternet: row.requiresInternet,
      installDependencies: row.installDependencies,
      backgroundInstall: row.backgroundInstall,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
