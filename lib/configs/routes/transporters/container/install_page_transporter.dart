import 'package:instaboo/configs/helpers/helpers_config.dart';
import 'package:instaboo/core/core.dart';

// A class to transport data and system information to the InstallPage
class InstallPageTransporter {
  final List<PackageData> data;
  final SystemInfoHelper system;
  final MethodCommandInfoHelper method;

  InstallPageTransporter(this.system, this.method, {required this.data});
}
