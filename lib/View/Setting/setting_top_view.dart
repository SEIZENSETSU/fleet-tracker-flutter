import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Setting/setting_top_controller.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Component/CustomWidget/custom_text.dart';

class SettingTopView extends StatefulWidget {
  const SettingTopView({super.key});

  @override
  State<SettingTopView> createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  SettingTopController controller = SettingTopController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                text: Strings.SETTING_ACOUNT_INFO,
                fontSize: 14,
              ),
            ),
          ),
          SettingTileCell().withDetail(
            title: 'ユーザー名',
            detail: '充電コード無くした人',
            onTap: () {
              // コメント投稿をする際の表示名を変更できる項目
            },
          ),
          if (kDebugMode)
            SettingTileCell().common(
              '開発用設定',
              isTapped: true,
              onTap: () {
                Log.echo('開発ボタン');
                controller.showDebugModal(context: context, size: size);
              },
            ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: Strings.SETTING_NOTIFICATION,
                fontSize: 14,
              ),
            ),
          ),
          SettingTileCell().withSwitch(
            subTitle: 'エリア通知',
            cellAction: (bool) {
              // エリア内に入る or エリアから出るで通知
            },
            switchValue: true,
          ),
          SettingTileCell().withSwitch(
            subTitle: '遅延情報通知',
            cellAction: (bool) {
              // 渋滞情報に変更があったら通知
            },
            switchValue: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: Strings.SETTING_OTHER,
                fontSize: 14,
              ),
            ),
          ),
          SettingTileCell().common('使い方', onTap: () {
            // dialog or ページを用意してこのアプリの使い方を説明する項目
          }),
          SettingTileCell().common('お問い合わせ', onTap: () {
            // お問い合わせを送信するページ
          }),
          SettingTileCell().common('アプリをレビューする', onTap: () {
            // ストアページのレビューへ遷移
          }),
          SettingTileCell().common('ライセンス', onTap: () {
            // ライセンスを表示
          }),
          SettingTileCell().withDetail(title: 'アプリバージョン', detail: 'v1.0.0'),
        ],
      ),
    );
  }
}
