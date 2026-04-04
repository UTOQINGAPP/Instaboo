/// Pack-software junction data entity (many-to-many).
/// Entidad de datos de unión pack-software (muchos a muchos).
///
/// Maps to: pack_software table
/// Mapea a: tabla pack_software
class PackSoftwareDataRule {
  /// Primary key.
  final int id;

  /// Foreign key to installation_packs.
  final int packId;

  /// Foreign key to software.
  final int softwareId;

  /// Sort order within the pack.
  final int sortOrder;

  /// Creation timestamp.
  final DateTime createdAt;

  const PackSoftwareDataRule({
    required this.id,
    required this.packId,
    required this.softwareId,
    this.sortOrder = 0,
    required this.createdAt,
  });

  PackSoftwareDataRule copyWith({
    int? id,
    int? packId,
    int? softwareId,
    int? sortOrder,
    DateTime? createdAt,
  }) => PackSoftwareDataRule(
    id: id ?? this.id,
    packId: packId ?? this.packId,
    softwareId: softwareId ?? this.softwareId,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
}
