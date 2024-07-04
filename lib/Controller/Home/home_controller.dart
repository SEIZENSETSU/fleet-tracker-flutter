import 'package:fleet_tracker/Constants/Enum/weather_state_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Weather/weather.dart';
import 'package:fleet_tracker/Model/Entity/Weather/weatherList.dart';
import 'package:fleet_tracker/Service/API/Original/road_information_service.dart';
import 'package:fleet_tracker/Service/API/WeatherInformation/weather_information_service.dart';

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
  Future<WeatherStateType?> getWeatherState({
    required double lat,
    required double lng,
    required bool isAfterOneHour,
  }) async {
    WeatherList? weatherList = await WeatherInformationService().getWeatherInformation(
      userLatitude: lat.toString(),
      userLongitude: lng.toString(),
    );

    if (weatherList == null) {
      return null;
    }

    /// いつの天気情報が欲しいか判定
    Weather weatherData;
    if (isAfterOneHour) {
      weatherData = weatherList.afterOneHour;
    } else {
      weatherData = weatherList.now;
    }

    /// 降水量によって天気を判定 ここは雰囲気
    /// 0.3mm未満: 晴れ
    /// 0.3mm以上1.0mm未満: 曇り
    /// 1.0mm以上: 雨
    if (weatherData.rainfall < 0.3) {
      return WeatherStateType(WeatherStateEnum.sun.name);
    } else if (weatherData.rainfall < 1.0) {
      return WeatherStateType(WeatherStateEnum.cloud.name);
    } else {
      return WeatherStateType(WeatherStateEnum.rain.name);
    }
  }
}
