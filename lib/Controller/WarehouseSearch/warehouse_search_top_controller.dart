import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Model/Entity/Warehouse/warehouse.dart';

class WarehouseSearchTopController {
  SharedPreferencesService prefs = SharedPreferencesService();

  final TextEditingController textEditingController = TextEditingController();
  bool mapSwitch = true;
  List<String> areaNameList = [
    '北海道',
    '東北',
    '関東',
    '中部',
    '近畿',
    '中国・四国',
    '九州',
  ];
  List<String> areaImageUrlList = [
    'https://www.c-ihighway.jp/smp/img/MAP/hokkaido.png',
    'https://www.c-ihighway.jp/smp/img/MAP/tohoku.png',
    'https://www.c-ihighway.jp/smp/img/MAP/kanto.png',
    'https://www.c-ihighway.jp/smp/img/MAP/hokuriku.png',
    'https://www.c-ihighway.jp/smp/img/MAP/kinki.png',
    'https://www.c-ihighway.jp/smp/img/MAP/chugoku.png',
    'https://www.c-ihighway.jp/smp/img/MAP/kyushu.png',
  ];

  /// 日本地図を表示するかgridで表示するかのboolを切り替える
  /// [flag]
  Future<void> setMapSwitch({required bool flag}) async {
    mapSwitch = flag;
    await prefs.setBool(SharedPreferencesKeysEnum.mapSwitch.name, flag);
  }

  Future<bool> getMapSwitch() async {
    bool? isMap = await prefs.getBool('mapSwitch');
    return isMap == null ? true : isMap;
  }

  /// テキストフィールドに入力された値が正しいフラグ
  /// [keyword]
  bool validationCheck({required String keyword}) {
    if (keyword == '') {
      Fluttertoast.showToast(msg: 'キーワードを入力してください。');
      return false;
    }

    return true;
  }

  /// ユーザーが登録しているお気に入り倉庫の情報を取得する
  Future<List<WarehouseInfo>?> getFavoriteWarehouses() async {
    List<WarehouseInfo> favoriteWarehouseList = [];
    // お気に入りに登録している倉庫IDを取得
    List<String>? favoriteId = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    Log.echo(favoriteId.toString(), symbol: '👞');

    //　IDで倉庫検索APIを叩く
    for (int i = 0; i < favoriteId!.length; i++) {
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
}
