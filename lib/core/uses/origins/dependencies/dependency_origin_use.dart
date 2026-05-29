import 'package:instaboo/core/infra/infra_core.dart';

/// Raw software dependency edge from Drift.
/// Arista de dependencia entre software cruda desde Drift.
class DependencyOriginUse {
  final int id;
  final int softwareId;
  final int dependencySoftwareId;
  final bool isRequired;
  final String? notes;
  final DateTime createdAt;

  const DependencyOriginUse({
    required this.id,
    required this.softwareId,
    required this.dependencySoftwareId,
    required this.isRequired,
    this.notes,
    required this.createdAt,
  });

  /// Builds from Drift row data. / Construye desde fila Drift.
  factory DependencyOriginUse.fromDrift(SoftwareDependenciesTableData row) =>
      DependencyOriginUse(
        id: row.id,
        softwareId: row.softwareId,
        dependencySoftwareId: row.dependencySoftwareId,
        isRequired: row.isRequired,
        notes: row.notes,
        createdAt: row.createdAt,
      );
}
