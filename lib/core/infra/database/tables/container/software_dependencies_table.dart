import 'package:drift/drift.dart';

import 'software_table.dart';

/// Dependency edge between two software rows.
/// Arista de dependencia entre dos filas de software.
@TableIndex(name: 'idx_deps_software', columns: {#softwareId})
@TableIndex(name: 'idx_deps_dependency', columns: {#dependencySoftwareId})
class SoftwareDependenciesTable extends Table {
  @override
  String get tableName => 'software_dependencies';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Software that depends on another.
  @ReferenceName('softwareDependencies')
  IntColumn get softwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// Required or recommended dependency target.
  @ReferenceName('dependencySoftware')
  IntColumn get dependencySoftwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// True if mandatory, false if recommended.
  BoolColumn get isRequired => boolean().withDefault(const Constant(true))();

  /// Optional notes for the dependency.
  TextColumn get notes => text().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {softwareId, dependencySoftwareId},
      ];
}
