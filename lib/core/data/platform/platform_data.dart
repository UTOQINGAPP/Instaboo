import 'package:isar/isar.dart';
part 'platform_data.g.dart';

// Describes PlatformData as a model for storing platform-specific information in an Isar database.

@Collection()
class PlatformData {
  Id id = Isar.autoIncrement;
  late String name;
  late int majorVersion;
  late int minorVersion;
  late int buildNumber;
  late String architecture;
}
