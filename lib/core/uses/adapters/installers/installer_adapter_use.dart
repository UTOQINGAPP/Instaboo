import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/origins/origins_uses.dart';

/// Maps between [InstallerOriginUse] and [InstallerDataRule].
/// Mapea entre [InstallerOriginUse] y [InstallerDataRule].
class InstallerAdapterUse {
  static InstallerDataRule toDataRule(InstallerOriginUse origin) =>
      InstallerDataRule.fromPersisted(
        id: origin.id,
        contentType: origin.contentType,
        mainExecutable: origin.mainExecutable,
        installerType: origin.installerType,
        silentArgs: origin.silentArgs,
        fileCount: origin.fileCount,
        totalSizeBytes: origin.totalSizeBytes,
        fileHashSha256: origin.fileHashSha256,
        originalName: origin.originalName,
        isVerified: origin.isVerified,
        lastVerifiedAt: origin.lastVerifiedAt,
        createdAt: origin.createdAt,
        updatedAt: origin.updatedAt,
      );

  static InstallerOriginUse toOriginUse(InstallerDataRule data) =>
      InstallerOriginUse(
        id: data.id,
        contentType: data.contentType,
        mainExecutable: data.mainExecutable,
        installerType: data.installerType,
        silentArgs: data.silentArgs,
        fileCount: data.fileCount,
        totalSizeBytes: data.totalSizeBytes,
        fileHashSha256: data.fileHashSha256,
        originalName: data.originalName,
        isVerified: data.isVerified,
        lastVerifiedAt: data.lastVerifiedAt,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
      );
}
