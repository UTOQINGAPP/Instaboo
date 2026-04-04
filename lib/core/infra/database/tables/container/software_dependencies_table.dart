import 'package:drift/drift.dart';

import 'software_table.dart';

/// Software dependencies (software requires other software).
/// Dependencias de software (un software requiere otro).
///
/// Maps to PostgreSQL: software_dependencies
/// Mapea a PostgreSQL: software_dependencies
@TableIndex(name: 'idx_software_dependencies_software_id', columns: {#softwareId})
@TableIndex(name: 'idx_software_dependencies_dependency_id', columns: {#dependencySoftwareId})
class SoftwareDependenciesTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to the software that has the dependency.
  @ReferenceName('softwareDependencies')
  IntColumn get softwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// Foreign key to the required dependency software.
  @ReferenceName('dependencySoftware')
  IntColumn get dependencySoftwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// Whether the dependency is required.
  BoolColumn get isRequired => boolean().withDefault(const Constant(true))();

  /// Version constraint (e.g. ">=1.0.0").
  TextColumn get versionConstraint => text().withLength(max: 100).nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {softwareId, dependencySoftwareId},
      ];
}
