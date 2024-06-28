import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';

class WarehouseSearchTopController {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  late bool mapSwitch;
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
