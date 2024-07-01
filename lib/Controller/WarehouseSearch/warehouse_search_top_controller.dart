import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:flutter/widgets.dart';

class WarehouseSearchTopController {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  final TextEditingController textEditingController = TextEditingController();
  late bool mapSwitch;
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
  WarehouseSearchTopController() {
    mapSwitch = true;
  }
  Future<bool> setMapSwitch({required bool mapSwitch}) async {
    return sharedPreferencesService.setBool('mapSwitch', !mapSwitch);
  }

  Future<bool> getMapSwitch() async {
    bool? isMap = await sharedPreferencesService.getBool('mapSwitch');
    return isMap == null ? true : isMap;
  }
}
