import 'package:isar/isar.dart';
part 'category_data.g.dart';
// Describes the CategoryData class as a model for storing category information in an Isar database.

@Collection()
class CategoryData {
  Id id = Isar.autoIncrement;
  late String name;
}
