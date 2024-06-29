import 'package:fleet_tracker/Controller/Setting/setting_top_controller.dart';
import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/area.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Constants/Enum/shared_preferences_keys_enum.dart';

class DebugModal {
  SharedPreferencesService prefs = SharedPreferencesService();

  showModal({
    required BuildContext context,
    required Size size,
  }) {
    CustomModal().showModal(
      context: context,
      size: size,
      title: '開発用設定',
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            FutureBuilder(
              future: prefs
                  .getBool(SharedPreferencesKeysEnum.forceInvadingMode.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SettingTileCell().withSwitch(
                  subTitle: 'エリアモードを強制する',
                  cellAction: (bool value) async {
                    bool forceInvadingMode = snapshot.data as bool;
                    await prefs.setBool(
                        SharedPreferencesKeysEnum.forceInvadingMode.name,
                        !forceInvadingMode);
                    Log.echo('エリアモード強制: ${!(forceInvadingMode)}');
                    setState(() {});
                  },
                  switchValue: snapshot.data as bool,
                );
              },
            ),
            FutureBuilder(
              future:
                  prefs.getBool(SharedPreferencesKeysEnum.forceIsInvading.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SettingTileCell().withSwitch(
                  subTitle: snapshot.data as bool ? 'エリアIN' : 'エリアOUT',
                  cellAction: (bool value) async {
                    bool forceIsInvading = snapshot.data as bool;
                    WarehouseSearchInfoData().setIsInvading(!forceIsInvading);
                    await prefs.setBool(
                        SharedPreferencesKeysEnum.forceIsInvading.name,
                        !forceIsInvading);
                    Log.echo('エリアIN/OUT強制: ${!(forceIsInvading)}');
                    WarehouseSearchInfoData().setIsInvading(!forceIsInvading);
                    setState(() {});
                  },
                  switchValue: snapshot.data as bool,
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
