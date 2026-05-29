import 'package:drift/drift.dart';

import 'installation_packs_table.dart';
import 'software_table.dart';

/// Ordered N:M link between packs and software.
/// Enlace N:M ordenado entre packs y software.
@TableIndex(name: 'idx_pack_items_pack', columns: {#packId})
@TableIndex(name: 'idx_pack_items_software', columns: {#softwareId})
class PackItemsTable extends Table {
  @override
  String get tableName => 'pack_items';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Owning pack.
  IntColumn get packId =>
      integer().references(InstallationPacksTable, #id, onDelete: KeyAction.cascade)();

  /// Software entry in the pack.
  IntColumn get softwareId =>
      integer().references(SoftwareTable, #id, onDelete: KeyAction.cascade)();

  /// Install order within the pack.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {packId, softwareId},
      ];
}
