import 'dart:ffi';

import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/warehouse.dart';
import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Geolocatorを利用して位置情報を取得するService
class GeolocatorService {
  /// 位置情報を取得する関数
  /// [Permission.location]の許可がない場合はnullを返す
  Future<Position?> getPosition() async {
    try {
      PermissionStatus status = await Permission.location.status;

      if (status.isDenied ||
          status.isRestricted ||
          status.isPermanentlyDenied) {
        throw Exception('Permission Error: $status');
      }

      /// 位置情報を取得
      Position position = await Geolocator.getCurrentPosition();

      return position;
    } catch (e) {
      Log.echo('getPosition: ${e.toString()}', symbol: '❌');
      return null;
    }
  }

  /// カスタムクラスのLocationをLocationパッケージを利用して取得
  Future<Location> getLocationAsCustom() async {
    Position? data = await getPosition();

    if (data == null) {
      throw Exception('Position Data Error: $data');
    }

    return Location(
      lat: data.latitude,
      lng: data.longitude,
      time: DateTime.now(),
    );
  }

  /// 現在の座標とエリアの座標から方位を計算する。
  /// [warehouseLat]
  /// [warehouseLon]
  calcBearingBetween({
    required double warehouseLat,
    required double warehouseLon,
  }) {
    double angle = Geolocator.bearingBetween(LocationData().getData().lat,
        LocationData().getData().lng, warehouseLat, warehouseLon);

    return angle;
  }
}
