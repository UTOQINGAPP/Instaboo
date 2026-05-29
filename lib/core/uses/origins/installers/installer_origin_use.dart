import 'package:instaboo/core/infra/infra_core.dart';

/// Raw installer row as read from SQLite (Drift).
/// Fila de instalador cruda leída de SQLite (Drift).
class InstallerOriginUse {
  final String id;
  final String contentType;
  final String mainExecutable;
  final String? installerType;
  final String? silentArgs;
  final int fileCount;
  final int? totalSizeBytes;
  final String? fileHashSha256;
  final String? originalName;
  final bool isVerified;
  final DateTime? lastVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InstallerOriginUse({
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

  /// Builds the origin from Drift row data.
  /// Construye el origen desde la fila Drift.
  factory InstallerOriginUse.fromDrift(InstallersTableData row) => InstallerOriginUse(
        id: row.id,
        contentType: row.contentType,
        mainExecutable: row.mainExecutable,
        installerType: row.installerType,
        silentArgs: row.silentArgs,
        fileCount: row.fileCount,
        totalSizeBytes: row.totalSizeBytes,
        fileHashSha256: row.fileHashSha256,
        originalName: row.originalName,
        isVerified: row.isVerified,
        lastVerifiedAt: row.lastVerifiedAt,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
