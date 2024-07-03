import '../../../Service/Package/DeviceInfo/device_info_service.dart';

class LicenseController {
  DeviceInfoService get _deviceInfoService => DeviceInfoService();

  String? applicationVersion;

  Future<String> getAppVersion() async {
    applicationVersion = await _deviceInfoService.getAppVersion();
    return applicationVersion!;
  }
}
