import 'package:drift/drift.dart';

import 'categories_table.dart';
import 'installer_frameworks_table.dart';
import 'installers_table.dart';

/// Installable software catalog; references one internal installer when set.
/// Catálogo de software instalable; referencia un instalador interno cuando aplica.
@TableIndex(name: 'idx_software_category', columns: {#categoryId})
@TableIndex(name: 'idx_software_slug', columns: {#slug})
@TableIndex(name: 'idx_software_installer', columns: {#installerId})
@TableIndex(name: 'idx_software_active', columns: {#isActive})
class SoftwareTable extends Table {
  @override
  String get tableName => 'software';

  /// Primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Display name (max 200).
  TextColumn get name => text().withLength(max: 200)();

  /// Stable unique slug (max 200).
  TextColumn get slug => text().withLength(max: 200).unique()();

  /// Version string (max 50).
  TextColumn get version => text().withLength(max: 50).nullable()();

  /// Long description.
  TextColumn get description => text().nullable()();

  /// Publisher name (max 200).
  TextColumn get publisher => text().withLength(max: 200).nullable()();

  /// Category reference.
  IntColumn get categoryId => integer().nullable().references(
        CategoriesTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Active internal installer folder id.
  TextColumn get installerId => text()
      .withLength(max: 20)
      .nullable()
      .references(InstallersTable, #id, onDelete: KeyAction.setNull)();

  /// Icon file name under `/icons/` (max 100).
  TextColumn get iconFilename => text().withLength(max: 100).nullable()();

  /// Whether silent installation can be used.
  BoolColumn get isAutoInstallable =>
      boolean().withDefault(const Constant(true))();

  /// Whether elevation is required.
  BoolColumn get requiresAdmin =>
      boolean().withDefault(const Constant(false))();

  /// Whether installation requires internet access.
  /// Si la instalacion requiere acceso a internet.
  BoolColumn get requiresInternet =>
      boolean().withDefault(const Constant(false))();

  /// Minimum OS string (max 30).
  TextColumn get minOsVersion => text().withLength(max: 30).nullable()();

  /// `x86`, `x64`, `arm64`, `any`, etc. (plain text from rules).
  TextColumn get architecture => text().nullable()();

  /// Informational website URL (max 500).
  TextColumn get websiteUrl => text().withLength(max: 500).nullable()();

  /// License label (max 50).
  TextColumn get licenseType => text().withLength(max: 50).nullable()();

  /// Notes and requirements.
  TextColumn get notes => text().nullable()();

  /// Reference to the installer framework type (for silent args resolution).
  /// Referencia al tipo de framework del instalador (para resolver args silenciosos).
  IntColumn get installerFrameworkId => integer().nullable().references(
        InstallerFrameworksTable,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Extra silent args appended on top of the framework's args.
  /// Args silenciosos extra que se agregan sobre los del framework.
  TextColumn get extraSilentArgs => text().nullable()();

  /// Whether this catalog row is active.
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
