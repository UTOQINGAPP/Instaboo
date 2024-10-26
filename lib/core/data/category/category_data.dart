import 'package:isar/isar.dart';
part 'category_data.g.dart';

@Collection()
class CategoryData {
  Id id = Isar.autoIncrement;
  late String name;
}
