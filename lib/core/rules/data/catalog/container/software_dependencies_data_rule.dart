/// Software dependency data entity.
/// Entidad de datos de dependencia de software.
///
/// Maps to: software_dependencies table
/// Mapea a: tabla software_dependencies
class SoftwareDependenciesDataRule {
  /// Primary key.
  final int id;

  /// Foreign key to the software that has the dependency.
  final int softwareId;

  /// Foreign key to the required dependency software.
  final int dependencySoftwareId;

  /// Whether the dependency is required.
  final bool isRequired;

  /// Version constraint (e.g. ">=1.0.0").
  final String? versionConstraint;

  /// Creation timestamp.
  final DateTime createdAt;

  const SoftwareDependenciesDataRule({
    required this.id,
    required this.softwareId,
    required this.dependencySoftwareId,
    this.isRequired = true,
    this.versionConstraint,
    required this.createdAt,
  });

  SoftwareDependenciesDataRule copyWith({
    int? id,
    int? softwareId,
    int? dependencySoftwareId,
    bool? isRequired,
    String? versionConstraint,
    DateTime? createdAt,
  }) => SoftwareDependenciesDataRule(
    id: id ?? this.id,
    softwareId: softwareId ?? this.softwareId,
    dependencySoftwareId: dependencySoftwareId ?? this.dependencySoftwareId,
    isRequired: isRequired ?? this.isRequired,
    versionConstraint: versionConstraint ?? this.versionConstraint,
    createdAt: createdAt ?? this.createdAt,
  );
}
