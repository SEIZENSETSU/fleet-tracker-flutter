import 'dart:async';

import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/area_search_info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/debug_modal.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:flutter/widgets.dart';

class SettingTopController {
  late bool isInArea;

  SettingTopController() {
    // Future(
    //   () async {
    //     bool? areaBool = await SharedPreferencesService().getBool('isInArea');
    //     if (areaBool != null) {
    //       isInArea = areaBool;
    //     } else {
    //       await SharedPreferencesService().setBool('iaInArea', true);
    //       isInArea = true;
    //     }
    //   },
    // );
  }

  showDebugModal({
    required BuildContext context,
    required Size size,
  }) {
    DebugModal().showModal(context: context, size: size, isInArea: isInArea!);
  }

  LocationData data = LocationData();
}
