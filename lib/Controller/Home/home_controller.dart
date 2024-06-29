import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:geocoding/geocoding.dart';

class HomeController {
  pushFunctionCard(int index) {
    BottomNavigationBarController().goBranch(index);
  }

  Future getCurrentAddress() async {
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
}
