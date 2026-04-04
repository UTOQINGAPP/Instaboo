import 'package:drift/drift.dart';

import 'installation_packs_table.dart';
import 'software_table.dart';

/// Many-to-many relationship between packs and software.
/// Relación muchos a muchos entre packs y software.
///
/// Maps to PostgreSQL: pack_software
/// Mapea a PostgreSQL: pack_software
@TableIndex(name: 'idx_pack_software_pack_id', columns: {#packId})
@TableIndex(name: 'idx_pack_software_software_id', columns: {#softwareId})
class PackSoftwareTable extends Table {
  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to installation_packs.
  IntColumn get packId =>
      integer().references(InstallationPacksTable, #id, onDelete: KeyAction.cascade)();

  /// Foreign key to software.
  IntColumn get softwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// Sort order within the pack.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {packId, softwareId},
      ];
}
