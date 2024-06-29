import 'package:fleet_tracker/Controller/Setting/setting_top_controller.dart';
import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/area.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugModal {
  showModal({
    required BuildContext context,
    required Size size,
  }) {
    CustomModal().showModal(
      context: context,
      size: size,
      title: '開発用設定',
      content: Consumer(
        builder: (context, ref, _) {
          final warehouseSearchInfo =
              ref.watch(warehouseSearchInfoDataProvider);
          return Column(
            children: [
              SettingTileCell().withSwitch(
                  subTitle: 'エリア内モード',
                  cellAction: (bool value) {
                    bool flagInvading =
                        warehouseSearchInfo.getData().isInvading;
                    WarehouseSearchInfoData().setIsInvading(!flagInvading);
                  },
                  switchValue: warehouseSearchInfo.getData().isInvading)
            ],
          );
        },
      ),
    );
  }
}
