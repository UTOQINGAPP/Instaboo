import 'package:isar/isar.dart';
part 'platform_data.g.dart';

@Collection()
class PlatformData {
  Id id = Isar.autoIncrement;
  late String name;
  late int majorVersion;
  late int minorVersion;
  late int buildNumber;
  late String architecture;
}
