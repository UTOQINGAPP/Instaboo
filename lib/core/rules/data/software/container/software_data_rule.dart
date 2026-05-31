class SoftwareDataRule {
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

  const SoftwareDataRule._({
    required this.id,
    required this.name,
    required this.slug,
    this.version,
    this.description,
    this.publisher,
    this.categoryId,
    this.installerId,
    this.iconFilename,
    this.isAutoInstallable = true,
    this.requiresAdmin = false,
    this.requiresInternet = false,
    this.installerFrameworkId,
    this.extraSilentArgs,
    this.minOsVersion,
    this.architecture,
    this.websiteUrl,
    this.licenseType,
    this.notes,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SoftwareDataRule.fromPersisted({
    required int id,
    required String name,
    required String slug,
    String? version,
    String? description,
    String? publisher,
    int? categoryId,
    String? installerId,
    String? iconFilename,
    bool isAutoInstallable = true,
    bool requiresAdmin = false,
    bool requiresInternet = false,
    int? installerFrameworkId,
    String? extraSilentArgs,
    String? minOsVersion,
    String? architecture,
    String? websiteUrl,
    String? licenseType,
    String? notes,
    bool isActive = true,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => SoftwareDataRule._(
    id: id,
    name: name,
    slug: slug,
    version: version,
    description: description,
    publisher: publisher,
    categoryId: categoryId,
    installerId: installerId,
    iconFilename: iconFilename,
    isAutoInstallable: isAutoInstallable,
    requiresAdmin: requiresAdmin,
    requiresInternet: requiresInternet,
    installerFrameworkId: installerFrameworkId,
    extraSilentArgs: extraSilentArgs,
    minOsVersion: minOsVersion,
    architecture: architecture,
    websiteUrl: websiteUrl,
    licenseType: licenseType,
    notes: notes,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  SoftwareDataRule copyWith({
    int? id,
    String? name,
    String? slug,
    String? version,
    String? description,
    String? publisher,
    int? categoryId,
    String? installerId,
    String? iconFilename,
    bool? isAutoInstallable,
    bool? requiresAdmin,
    bool? requiresInternet,
    int? installerFrameworkId,
    String? extraSilentArgs,
    String? minOsVersion,
    String? architecture,
    String? websiteUrl,
    String? licenseType,
    String? notes,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SoftwareDataRule._(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    version: version ?? this.version,
    description: description ?? this.description,
    publisher: publisher ?? this.publisher,
    categoryId: categoryId ?? this.categoryId,
    installerId: installerId ?? this.installerId,
    iconFilename: iconFilename ?? this.iconFilename,
    isAutoInstallable: isAutoInstallable ?? this.isAutoInstallable,
    requiresAdmin: requiresAdmin ?? this.requiresAdmin,
    requiresInternet: requiresInternet ?? this.requiresInternet,
    installerFrameworkId: installerFrameworkId ?? this.installerFrameworkId,
    extraSilentArgs: extraSilentArgs ?? this.extraSilentArgs,
    minOsVersion: minOsVersion ?? this.minOsVersion,
    architecture: architecture ?? this.architecture,
    websiteUrl: websiteUrl ?? this.websiteUrl,
    licenseType: licenseType ?? this.licenseType,
    notes: notes ?? this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  String toString() {
    return 'SoftwareDataRule(id: $id, name: $name, slug: $slug, version: $version, description: $description, publisher: $publisher, categoryId: $categoryId, installerId: $installerId, iconFilename: $iconFilename, isAutoInstallable: $isAutoInstallable, requiresAdmin: $requiresAdmin, requiresInternet: $requiresInternet, installerFrameworkId: $installerFrameworkId, extraSilentArgs: $extraSilentArgs, minOsVersion: $minOsVersion, architecture: $architecture, websiteUrl: $websiteUrl, licenseType: $licenseType, notes: $notes, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SoftwareDataRule &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.version == version &&
        other.description == description &&
        other.publisher == publisher &&
        other.categoryId == categoryId &&
        other.installerId == installerId &&
        other.iconFilename == iconFilename &&
        other.isAutoInstallable == isAutoInstallable &&
        other.requiresAdmin == requiresAdmin &&
        other.requiresInternet == requiresInternet &&
        other.installerFrameworkId == installerFrameworkId &&
        other.extraSilentArgs == extraSilentArgs &&
        other.minOsVersion == minOsVersion &&
        other.architecture == architecture &&
        other.websiteUrl == websiteUrl &&
        other.licenseType == licenseType &&
        other.notes == notes &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    slug,
    version,
    description,
    publisher,
    categoryId,
    installerId,
    iconFilename,
    isAutoInstallable,
    requiresAdmin,
    requiresInternet,
    installerFrameworkId,
    extraSilentArgs,
    minOsVersion,
    architecture,
    websiteUrl,
    licenseType,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ]);

}
