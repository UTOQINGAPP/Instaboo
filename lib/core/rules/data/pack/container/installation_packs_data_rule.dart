/// Installation pack data entity (bundle of software).
/// Entidad de datos de pack de instalación (paquete de software).
///
/// Maps to: installation_packs table
/// Mapea a: tabla installation_packs
class InstallationPacksDataRule {
  /// Primary key.
  final int id;

  /// Pack name (unique).
  final String name;

  /// Optional description.
  final String? description;

  /// Whether the pack is active.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime updatedAt;

  const InstallationPacksDataRule({
    required this.id,
    required this.name,
    this.description,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  InstallationPacksDataRule copyWith({
    int? id,
    String? name,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InstallationPacksDataRule(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
