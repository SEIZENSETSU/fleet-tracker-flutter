import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Weather/weatherList.dart';
import 'package:fleet_tracker/Service/API/Original/road_information_service.dart';
import 'package:fleet_tracker/Service/API/WeatherInformation/weather_information_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:geocoding/geocoding.dart';

import '../../Model/Entity/Warehouse/warehouse.dart';
import '../../Service/API/Original/warehouse_service.dart';

class HomeController {
  pushFunctionCard(int index) {
    BottomNavigationBarController().goBranch(index);
  }

  Future<String> getCurrentAddress() async {
    /// 日本語設定
    await GeocodingPlatform.instance!.setLocaleIdentifier("JP");
    final placemark = await placemarkFromCoordinates(
      LocationData().getData().lat,
      LocationData().getData().lng,
    );

    /// 整形して一文にして返す
    /// 例) 東京都新宿区
    return '${placemark[0].administrativeArea}${placemark[0].locality}';
  }

  /// ConsumerのデータからwarehouseIdをもらってWarehouse型を返す。
  /// [id] warehouseId
  Future getWarehouseList(int id) async {
    Warehouse? warehouse = await WarehouseService().getWarehouseInfo(warehouseId: id);

    if (warehouse == null) {
      return;
    }

    return warehouse;
  }

  /// 遅延状況をボタン押下時に送信する。
  Future pushDelayDetailButton() async {}

  /// 現在地から最寄りの道路名を取得する
  /// [lat] 緯度
  /// [lng] 経度
  Future<String> getNearestRoadName({required double lat, required double lng}) async {
    String? nearestRoadName = await RoadInformationService().getNearestRoadName(
      latitude: lat,
      longitude: lng,
    );

    /// 付近100m以内に高速道路が見つからなかった場合、空文字を返す
    if (nearestRoadName == null) {
      return '';
    }
    // ここはとってくる文字列のパターンがもっとある可能性あるからsplitするやつ増える可能性大
    List<String> spliteNearestRoadName = nearestRoadName.split(';')[0].split('('[0]);

    nearestRoadName = spliteNearestRoadName[0];

    return '$nearestRoadNameを走行中';
  }

  /// 現在地の天気を取得する
  /// [lat] 緯度
  /// [lng] 経度
  Future<String?> getNowWeatherState({
    required double lat,
    required double lng,
  }) async {
    WeatherList? weatherList = await WeatherInformationService().getWeatherInformation(
      userLatitude: lat.toString(),
      userLongitude: lng.toString(),
    );

    if (weatherList == null) {
      return null;
    }

    /// 降水量によって天気を判定 ここは雰囲気
    /// 0.3mm未満: 晴れ
    /// 0.3mm以上1.0mm未満: 曇り
    /// 1.0mm以上: 雨
    if (weatherList.now.rainfall < 0.3) {
      return 'sun';
    } else if (weatherList.now.rainfall < 1.0) {
      return 'cloud';
    } else {
      return 'rain';
    }
  }

  /// 1時間後の天気を取得する
  /// [lat] 緯度
  /// [lng] 経度
  Future<String?> getAfterOneHourWeatherState({
    required double lat,
    required double lng,
  }) async {
    WeatherList? weatherList = await WeatherInformationService().getWeatherInformation(
      userLatitude: lat.toString(),
      userLongitude: lng.toString(),
    );

    if (weatherList == null) {
      return null;
    }

    if (weatherList.afterOneHour.rainfall < 0.3) {
      return 'sun';
    } else if (weatherList.afterOneHour.rainfall < 1.0) {
      return 'cloud';
    } else {
      return 'rain';
    }
  }
}
