import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Service/Package/Location/location_package_service.dart';

class LocationData {
  static final LocationData _instance = LocationData._internal();
  factory LocationData() => _instance;
  LocationData._internal();

  LocationPackageService get locationPackageService => LocationPackageService();

  Location? _data;

  /// getter
  Location getData() {
    return _data!;
  }

  /// setter
  /// force = trueの場合のみawaitが必要
  /// [data] 位置情報
  /// [force] 強制的に位置情報をSetするかどうか
  Future<void> setData({
    Location? data,
    bool force = false,
  }) async {
    /// Locationパッケージを利用して強制的に位置情報をSetする
    if (force || data == null || _data == null) {
      data = await locationPackageService.getLocationAsCustom();
    }
    _data = data;
  }
}
