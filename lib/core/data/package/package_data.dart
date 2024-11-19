import 'package:instaboo/core/data/category/category_data.dart';
import 'package:instaboo/core/data/platform/platform_data.dart';
import 'package:isar/isar.dart';
part 'package_data.g.dart';

// Describes PackageData as a model for storing package information in an Isar database.

@collection
class PackageData {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late String version;
  final category = IsarLink<CategoryData>();
  final platforms = IsarLinks<PlatformData>();
  late bool requiresInternet;
  late String executable;
}
