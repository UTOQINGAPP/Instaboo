import 'package:instaboo/core/infra/infra_core.dart';

class SoftwareOriginUse {
  final int id;
  final String name;
  final String slug;
  final String? version;
  final String? description;
  final String? publisher;
  final int? categoryId;
  final String? installerId;
  final String? iconFilename;
  final bool isAutoInstallable;
  final bool requiresAdmin;
  final bool requiresInternet;
  final int? installerFrameworkId;
  final String? extraSilentArgs;
  final String? minOsVersion;
  final String? architecture;
  final String? websiteUrl;
  final String? licenseType;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SoftwareOriginUse({
    required this.id,
    required this.name,
    required this.slug,
    this.version,
    this.description,
    this.publisher,
    this.categoryId,
    this.installerId,
    this.iconFilename,
    required this.isAutoInstallable,
    required this.requiresAdmin,
    this.requiresInternet = false,
    this.installerFrameworkId,
    this.extraSilentArgs,
    this.minOsVersion,
    this.architecture,
    this.websiteUrl,
    this.licenseType,
    this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory that builds the origin from Drift TableData.
  factory SoftwareOriginUse.fromDrift(SoftwareTableData row) {
    return SoftwareOriginUse(
      id: row.id,
      name: row.name,
      slug: row.slug,
      version: row.version,
      description: row.description,
      publisher: row.publisher,
      categoryId: row.categoryId,
      installerId: row.installerId,
      iconFilename: row.iconFilename,
      isAutoInstallable: row.isAutoInstallable,
      requiresAdmin: row.requiresAdmin,
      requiresInternet: row.requiresInternet,
      installerFrameworkId: row.installerFrameworkId,
      extraSilentArgs: row.extraSilentArgs,
      minOsVersion: row.minOsVersion,
      architecture: row.architecture,
      websiteUrl: row.websiteUrl,
      licenseType: row.licenseType,
      notes: row.notes,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
