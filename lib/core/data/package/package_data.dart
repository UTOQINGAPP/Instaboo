import 'package:instaboo/core/data/category/category_data.dart';
import 'package:instaboo/core/data/platform/platform_data.dart';
import 'package:isar/isar.dart';
part 'package_data.g.dart';

@collection
class PackageData {
  Id id = Isar.autoIncrement;

  String? iconPath;

  late String name;
  late String description;
  late String version;
  final category = IsarLink<CategoryData>();
  final platforms = IsarLinks<PlatformData>();
  late bool requiresInternet;
}
