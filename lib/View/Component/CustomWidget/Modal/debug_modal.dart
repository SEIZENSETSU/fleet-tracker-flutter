import 'package:fleet_tracker/Controller/Setting/setting_top_controller.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:flutter/cupertino.dart';

class DebugModal {
  showModal(
      {required BuildContext context,
      required Size size,
      required bool isInArea}) {
    CustomModal().showModal(
      context: context,
      size: size,
      title: '開発用設定',
      content: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Column(
            children: [
              SettingTileCell().withSwitch(
                subTitle: 'エリア内モード',
                cellAction: (bool value) {
                  setState(() async {
                    isInArea = !isInArea;
                    await SharedPreferencesService()
                        .setBool('isInArea', isInArea);
                  });
                },
                switchValue: isInArea,
              )
            ],
          );
        },
      ),
    );
    return isInArea;
  }
}
