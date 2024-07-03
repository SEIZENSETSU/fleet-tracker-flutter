import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoService {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  static Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

  Future<String> getAppVersion() async {
    final PackageInfo info = await packageInfo;
    return info.version;
  }

  Future<String> getDeviceOSVersion() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return "Android ${androidInfo.version.release}";
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return "iOS ${iosInfo.systemVersion}";
    }

    return "Unknown";
  }

  Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }

    return "Unknown";
  }
}
