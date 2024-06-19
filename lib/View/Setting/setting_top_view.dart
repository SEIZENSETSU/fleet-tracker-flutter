import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import '../Component/CustomWidget/Setting/setting_tile_cell.dart';

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info,
            ),
            color: ColorName.mainthemeColor,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '個人設定',
                fontSize: 20,
              ),
            ),
            SettingTileCell().common('ユーザー'),
            SettingTileCell().withDetail(title: 'ガイドとアラーム', detail: '設定なし'),
            SettingTileCell().common('プライバシー設定'),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '運行情報',
                fontSize: 20,
              ),
            ),
            SettingTileCell().common('登録道路'),
            SettingTileCell().common('通知路線'),
            SettingTileCell().common('ユーザー'),
            SettingTileCell().common('ユーザー'),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '個人設定',
                fontSize: 20,
              ),
            ),
            SettingTileCell().common('ユーザー'),
            SettingTileCell().common('ユーザー'),
            SettingTileCell().common('ユーザー'),
            SettingTileCell().common('ユーザー'),
          ],
        ),
      ),
    );
  }
}
