import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import '../Component/CustomWidget/custom_text.dart';

class SettingTopView extends StatefulWidget {
  const SettingTopView({super.key});

  @override
  State<SettingTopView> createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: '設定',
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: 'アカウント設定',
                fontSize: 14,
              ),
            ),
          ),
          SettingTileCell().withDetail(title: 'ユーザー名', detail: '充電コード無くした人'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: '通知設定',
                fontSize: 14,
              ),
            ),
          ),
          SettingTileCell().withSwitch(
            subTitle: 'エリア通知',
            cellAction: (bool) {},
            switchValue: true,
          ),
          SettingTileCell().withSwitch(
            subTitle: '',
            cellAction: (bool) {},
            switchValue: true,
          ),
        ],
      ),
    );
  }
}
