import 'package:fleet_tracker/View/Component/CustomCell/setting/settingTile_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SettingTopView extends StatefulWidget {
  const SettingTopView({super.key});

  @override
  State<SettingTopView> createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '設定',
        foregroundColor: ColorName.textBlack,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SettingTileCell().settingCell('設定'),
          SettingTileCell().settingCellDetail(title: '設定', detail: 'プラン1'),
          SettingTileCell().settingCellWithSwitch(
            subTitle: 'ダークモード',
            cellAction: (bool) {},
            switchValue: true,
          )
        ],
      ),
    );
  }
}
