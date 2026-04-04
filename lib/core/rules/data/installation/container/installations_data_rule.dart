import 'package:instaboo/core/rules/enums/enums_rule.dart';

/// Installation data entity for tracking progress.
/// Entidad de datos de instalación para seguimiento del progreso.
///
/// Maps to: installations table
/// Mapea a: tabla installations
class InstallationsDataRule {
  /// Primary key.
  final int id;

  /// Source type: software or pack.
  final InstallationSourceTypeEnumRule sourceType;

  /// Foreign key to software (when source_type = 'software').
  final int? softwareId;

  /// Foreign key to pack (when source_type = 'pack').
  final int? packId;

  /// Display name for the installation.
  final String displayName;

  /// Installation status.
  final InstallationStatusEnumRule status;

  /// Progress percentage (0-100).
  final int progress;

  /// Position in the installation queue.
  final int? queuePosition;

  /// When installation started.
  final DateTime? startedAt;

  /// When installation completed.
  final DateTime? completedAt;

  /// Error message if failed.
  final String? errorMessage;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const InstallationsDataRule({
    required this.id,
    required this.sourceType,
    this.softwareId,
    this.packId,
    required this.displayName,
    required this.status,
    this.progress = 0,
    this.queuePosition,
    this.startedAt,
    this.completedAt,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  InstallationsDataRule copyWith({
    int? id,
    InstallationSourceTypeEnumRule? sourceType,
    int? softwareId,
    int? packId,
    String? displayName,
    InstallationStatusEnumRule? status,
    int? progress,
    int? queuePosition,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationsDataRule(
    id: id ?? this.id,
    sourceType: sourceType ?? this.sourceType,
    softwareId: softwareId ?? this.softwareId,
    packId: packId ?? this.packId,
    displayName: displayName ?? this.displayName,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    queuePosition: queuePosition ?? this.queuePosition,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt ?? this.completedAt,
    errorMessage: errorMessage ?? this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
