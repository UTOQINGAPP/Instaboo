import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

class SoftwareAdapterUse {
  static SoftwareDataRule toDataRule(SoftwareOriginUse origin) =>
      SoftwareDataRule.fromPersisted(
        id: origin.id,
        name: origin.name,
        slug: origin.slug,
        version: origin.version,
        description: origin.description,
        publisher: origin.publisher,
        categoryId: origin.categoryId,
        installerId: origin.installerId,
        iconFilename: origin.iconFilename,
        isAutoInstallable: origin.isAutoInstallable,
        requiresAdmin: origin.requiresAdmin,
        requiresInternet: origin.requiresInternet,
        installerFrameworkId: origin.installerFrameworkId,
        extraSilentArgs: origin.extraSilentArgs,
        minOsVersion: origin.minOsVersion,
        architecture: origin.architecture,
        websiteUrl: origin.websiteUrl,
        licenseType: origin.licenseType,
        notes: origin.notes,
        isActive: origin.isActive,
        createdAt: origin.createdAt,
        updatedAt: origin.updatedAt,
      );

  static SoftwareOriginUse toOriginUse(SoftwareDataRule data) => SoftwareOriginUse(
    id: data.id,
    name: data.name,
    slug: data.slug,
    version: data.version,
    description: data.description,
    publisher: data.publisher,
    categoryId: data.categoryId,
    installerId: data.installerId,
    iconFilename: data.iconFilename,
    isAutoInstallable: data.isAutoInstallable,
    requiresAdmin: data.requiresAdmin,
    requiresInternet: data.requiresInternet,
    installerFrameworkId: data.installerFrameworkId,
    extraSilentArgs: data.extraSilentArgs,
    minOsVersion: data.minOsVersion,
    architecture: data.architecture,
    websiteUrl: data.websiteUrl,
    licenseType: data.licenseType,
    notes: data.notes,
    isActive: data.isActive,
    createdAt: data.createdAt,
    updatedAt: data.updatedAt,
  );
}
