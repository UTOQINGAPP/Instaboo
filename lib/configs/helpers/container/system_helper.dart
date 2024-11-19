import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class SystemInfoHelper {
  final String productName;
  final String displayVersion;
  final int buildNumber;
  final String deviceId;
  final String userName;
  final int majorVersion;
  final int minorVersion;

  SystemInfoHelper({
    required this.productName,
    required this.displayVersion,
    required this.buildNumber,
    required this.deviceId,
    required this.userName,
    required this.majorVersion,
    required this.minorVersion,
  });
}


class SystemHelper {
  /// Asynchronously retrieves Windows system information
  static Future<SystemInfoHelper> getWindowsSystemInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (!Platform.isWindows) {
      throw UnsupportedError('Esta función solo está disponible en Windows.');
    }

    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;

    return SystemInfoHelper(
      productName: windowsInfo.productName,
      displayVersion: windowsInfo.displayVersion,
      buildNumber: windowsInfo.buildNumber,
      deviceId: windowsInfo.deviceId,
      userName: windowsInfo.userName,
      majorVersion: windowsInfo.majorVersion,
      minorVersion: windowsInfo.minorVersion,
    );
  }
}