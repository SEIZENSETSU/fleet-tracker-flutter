import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Constants/Enum/weather_state_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/Weather/weather.dart';
import 'package:fleet_tracker/Model/Entity/Weather/weatherList.dart';
import 'package:fleet_tracker/Service/API/Original/road_information_service.dart';
import 'package:fleet_tracker/Service/API/WeatherInformation/weather_information_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:intl/intl.dart';

import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Model/Entity/Warehouse/warehouse.dart';
import '../../Service/API/Original/warehouse_service.dart';

class HomeController {
  SharedPreferencesService prefs = SharedPreferencesService();
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
    Warehouse? warehouse =
        await WarehouseService().getWarehouseInfo(warehouseId: id);

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
  Future<String> getNearestRoadName(
      {required double lat, required double lng}) async {
    String? nearestRoadName = await RoadInformationService().getNearestRoadName(
      latitude: lat,
      longitude: lng,
    );

    /// 付近100m以内に高速道路が見つからなかった場合、空文字を返す
    if (nearestRoadName == null) {
      return '高速道路を走行していません';
    }
    // ここはとってくる文字列のパターンがもっとある可能性あるからsplitするやつ増える可能性大
    List<String> spliteNearestRoadName =
        nearestRoadName.split(';')[0].split('('[0]);

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
    WeatherList? weatherList =
        await WeatherInformationService().getWeatherInformation(
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

  Future<String> getNowTime(DateTime now) async {
    final formatter = DateFormat('HH:mm');
    String formatted = formatter.format(now);

    return formatted;
  }

  /// ユーザーが登録しているお気に入り倉庫の情報を取得する
  Future<List<WarehouseInfo>?> getFavoriteWarehouses() async {
    List<WarehouseInfo> favoriteWarehouseList = [];
    // お気に入りに登録している倉庫IDを取得
    List<String>? favoriteId = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    Log.echo(favoriteId.toString(), symbol: '👞');
    if (favoriteId!.isEmpty) {
      return null;
    }
    //　IDで倉庫検索APIを叩く
    for (int i = 0; i < favoriteId.length; i++) {
      WarehouseSearchInfo? warehouseInfo = await WarehouseService()
          .searchWarehouseList(
              userLatitude: LocationData().getData().lat,
              userLongitude: LocationData().getData().lng,
              favoriteWarehouseIds: int.parse(favoriteId[i]));
      if (warehouseInfo != null) {
        favoriteWarehouseList.add(warehouseInfo.favoriteWarehouses![0]);
      }
    }
    return favoriteWarehouseList;
  }

  Future<PermissionStatus> getLocationPermission() async {
    return Permission.location.status;
  }

  Future<void> requestLocationPermission() async {
    openAppSettings();
  }
}
