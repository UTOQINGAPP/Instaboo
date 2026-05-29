import 'package:drift/drift.dart';

/// Managed installer folder under `/installers/{id}/` (filesystem truth).
/// Carpeta de instalador gestionada bajo `/installers/{id}/` (fuente de verdad en disco).
class InstallersTable extends Table {
  @override
  String get tableName => 'installers';

  @override
  Set<Column> get primaryKey => {id};

  /// Folder id (also directory name), max 20 chars.
  TextColumn get id => text().withLength(max: 20)();

  /// `single_file`, `directory`, or `packaged` (stored as plain text from rules).
  TextColumn get contentType => text()();

  /// Main executable file name inside the folder (max 255).
  TextColumn get mainExecutable => text().withLength(max: 255)();

  /// `exe`, `msi`, `msix`, `other`, or null (plain text from rules).
  TextColumn get installerType => text().nullable()();

  /// Silent install arguments (max 500).
  TextColumn get silentArgs => text().withLength(max: 500).nullable()();

  /// Number of files in the installer folder.
  IntColumn get fileCount => integer().withDefault(const Constant(1))();

  /// Total size in bytes of all files in the folder.
  IntColumn get totalSizeBytes => integer().nullable()();

  /// SHA-256 of the main executable (max 64 hex).
  TextColumn get fileHashSha256 => text().withLength(max: 64).nullable()();

  /// Original user-selected name (informational).
  TextColumn get originalName => text().withLength(max: 255).nullable()();

  /// Whether the last existence check succeeded.
  BoolColumn get isVerified => boolean().withDefault(const Constant(true))();

  /// Last integrity verification time.
  DateTimeColumn get lastVerifiedAt => dateTime().nullable()();

  /// Creation timestamp.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Last update timestamp.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
