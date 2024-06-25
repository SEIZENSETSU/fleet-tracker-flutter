import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:location/location.dart' as package;
import 'package:permission_handler/permission_handler.dart';

/// Locationパッケージを利用して位置情報を取得するService
class LocationPackageService {
  /// 位置情報を取得する関数
  /// [Permission.location]の許可がない場合はnullを返す
  Future<package.LocationData?> getLocation() async {
    try {
      PermissionStatus status = await Permission.location.status;

      if (status.isDenied ||
          status.isRestricted ||
          status.isPermanentlyDenied) {
        throw Exception('Permission Error: $status');
      }

      /// 位置情報を取得
      package.Location location = package.Location();
      package.LocationData data = await location.getLocation();

      if (data.latitude == null || data.longitude == null) {
        throw Exception('Package Location Error: ${data.toString()}');
      }

      return data;
    } catch (e) {
      Log.echo('getLocation: ${e.toString()}', symbol: '❌');
      return null;
    }
  }

  /// カスタムクラスのLocationをLocationパッケージを利用して取得
  Future<Location> getLocationAsCustom() async {
    package.LocationData? data = await getLocation();

    if (data == null) {
      throw Exception('Location Data Error: $data');
    }

    return Location(
      lat: data.latitude!,
      lng: data.longitude!,
      time: DateTime.now(),
    );
  }
}
