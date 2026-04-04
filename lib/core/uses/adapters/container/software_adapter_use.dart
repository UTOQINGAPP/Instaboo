import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/container/software_origin_use.dart';

/// Adapter between [SoftwareDriftOriginUse] and [SoftwareDataRule].
/// Only exposes [fromOrigin] (origin → data) and [toOrigin] (data → origin).
///
/// Adaptador entre [SoftwareDriftOriginUse] y [SoftwareDataRule].
/// Solo expone [fromOrigin] (origen → data) y [toOrigin] (data → origen).
class SoftwareAdapterUse {
  SoftwareAdapterUse._();

  /// Converts origin to [SoftwareDataRule] (domain data). Uses [origin.categoryId] only.
  /// Convierte origen a [SoftwareDataRule] (dato de dominio). Usa solo [origin.categoryId].
  static SoftwareDataRule fromOrigin(SoftwareDriftOriginUse origin) {
    return SoftwareDataRule(
      id: origin.id,
      name: origin.name,
      slug: origin.slug,
      version: origin.version,
      categoryId: origin.categoryId,
      sizeMb: origin.sizeMb,
      description: origin.description,
      logo: origin.logo,
      installationType: InstallationTypeEnumRule.values.byName(
        origin.installationType.name,
      ),
      installerSourceType: InstallerSourceTypeEnumRule.values.byName(
        origin.installerSourceType.name,
      ),
      installerSource: origin.installerSource,
      silentArgs: origin.silentArgs,
      minRamGb: origin.minRamGb,
      minDiskGb: origin.minDiskGb,
      operatingSystem: origin.operatingSystem,
      requiresRestart: origin.requiresRestart,
      requiresInternet: origin.requiresInternet,
      installDependencies: origin.installDependencies,
      backgroundInstall: origin.backgroundInstall,
      isActive: origin.isActive,
      createdAt: origin.createdAt,
      updatedAt: origin.updatedAt,
    );
  }

  /// Converts [SoftwareDataRule] to origin (for use when writing back to DB context).
  /// Convierte [SoftwareDataRule] a origen (para uso al escribir de vuelta al contexto DB).
  static SoftwareDriftOriginUse toOrigin(SoftwareDataRule data) {
    return SoftwareDriftOriginUse(
      id: data.id,
      name: data.name,
      slug: data.slug,
      version: data.version,
      categoryId: data.categoryId,
      sizeMb: data.sizeMb,
      description: data.description,
      logo: data.logo,
      installationType: InstallationTypeEnumDatabase.values.byName(
        data.installationType.name,
      ),
      installerSourceType: InstallerSourceTypeEnumDatabase.values.byName(
        data.installerSourceType.name,
      ),
      installerSource: data.installerSource,
      silentArgs: data.silentArgs,
      minRamGb: data.minRamGb,
      minDiskGb: data.minDiskGb,
      operatingSystem: data.operatingSystem,
      requiresRestart: data.requiresRestart,
      requiresInternet: data.requiresInternet,
      installDependencies: data.installDependencies,
      backgroundInstall: data.backgroundInstall,
      isActive: data.isActive,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
