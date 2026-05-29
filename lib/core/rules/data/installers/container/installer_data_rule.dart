class InstallerDataRule {
  final String id;
  final String contentType; // single_file, directory, packaged
  final String mainExecutable;
  final String? installerType; // exe, msi, msix, other
  final String? silentArgs;
  final int fileCount;
  final int? totalSizeBytes;
  final String? fileHashSha256;
  final String? originalName;
  final bool isVerified;
  final DateTime? lastVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InstallerDataRule._({
    required this.id,
    required this.contentType,
    required this.mainExecutable,
    this.installerType,
    this.silentArgs,
    required this.fileCount,
    this.totalSizeBytes,
    this.fileHashSha256,
    this.originalName,
    required this.isVerified,
    this.lastVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InstallerDataRule.fromPersisted({
    required String id,
    required String contentType,
    required String mainExecutable,
    String? installerType,
    String? silentArgs,
    required int fileCount,
    int? totalSizeBytes,
    String? fileHashSha256,
    String? originalName,
    required bool isVerified,
    DateTime? lastVerifiedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) => InstallerDataRule._(
    id: id,
    contentType: contentType,
    mainExecutable: mainExecutable,
    installerType: installerType,
    silentArgs: silentArgs,
    fileCount: fileCount,
    totalSizeBytes: totalSizeBytes,
    fileHashSha256: fileHashSha256,
    originalName: originalName,
    isVerified: isVerified,
    lastVerifiedAt: lastVerifiedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  InstallerDataRule copyWith({
    String? id,
    String? contentType,
    String? mainExecutable,
    String? installerType,
    String? silentArgs,
    int? fileCount,
    int? totalSizeBytes,
    String? fileHashSha256,
    String? originalName,
    bool? isVerified,
    DateTime? lastVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallerDataRule._(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    mainExecutable: mainExecutable ?? this.mainExecutable,
    installerType: installerType ?? this.installerType,
    silentArgs: silentArgs ?? this.silentArgs,
    fileCount: fileCount ?? this.fileCount,
    totalSizeBytes: totalSizeBytes ?? this.totalSizeBytes,
    fileHashSha256: fileHashSha256 ?? this.fileHashSha256,
    originalName: originalName ?? this.originalName,
    isVerified: isVerified ?? this.isVerified,
    lastVerifiedAt: lastVerifiedAt ?? this.lastVerifiedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstallerDataRule &&
          id == other.id &&
          contentType == other.contentType &&
          mainExecutable == other.mainExecutable &&
          installerType == other.installerType &&
          silentArgs == other.silentArgs &&
          fileCount == other.fileCount &&
          totalSizeBytes == other.totalSizeBytes &&
          fileHashSha256 == other.fileHashSha256 &&
          originalName == other.originalName &&
          isVerified == other.isVerified &&
          lastVerifiedAt == other.lastVerifiedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    contentType,
    mainExecutable,
    installerType,
    silentArgs,
    fileCount,
    totalSizeBytes,
    fileHashSha256,
    originalName,
    isVerified,
    lastVerifiedAt,
    createdAt,
    updatedAt,
  );
}
