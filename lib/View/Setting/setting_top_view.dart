import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Setting/setting_top_controller.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Setting/setting_tile_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../Route/router.dart';
import '../Component/CustomWidget/Modal/rename_modal.dart';
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
      body: FutureBuilder(
        future: controller.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Column(
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
                detail: controller.userName ?? "",
                onTap: () {
                  // コメント投稿をする際の表示名を変更できる項目
                  Log.echo('名前変更');
                  controller.showReNameModal(
                    context: context,
                    size: size,
                  );
                },
              ),
              if (kDebugMode)
                SettingTileCell().common(
                  '開発用設定',
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
                  controller.areaSwitchValue = bool;
                  controller.actionAreaSwitch(value: bool);
                  setState(() {});
                },
                switchValue: controller.areaSwitchValue ?? true,
              ),
              SettingTileCell().withSwitch(
                subTitle: '遅延情報通知',
                cellAction: (bool) {
                  // 渋滞情報に変更があったら通知
                  controller.delaySwitchValue = bool;
                  controller.actionDelaySwitch(value: bool);
                  setState(() {});
                },
                switchValue: controller.delaySwitchValue ?? true,
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
              SettingTileCell().common(
                '使い方',
                onTap: () {
                  const HowToUseRoute().push(context);
                },
              ),
              SettingTileCell().common(
                'お問い合わせ',
                onTap: () {
                  // お問い合わせを送信するページ
                  controller.openInquiry();
                },
              ),
              SettingTileCell().common(
                'アプリをレビューする',
                onTap: () {
                  // ストアページのレビューへ遷移
                  controller.openReview();
                },
              ),
              SettingTileCell().common(
                'プライバシーポリシー',
                onTap: () {
                  // プライバシーポリシー
                  controller.openPrivacyPolicy();
                },
              ),
              SettingTileCell().common(
                'ライセンス',
                onTap: () {
                  // ライセンスを表示
                  const LicenseRoute().push(context);
                },
              ),
              SettingTileCell().withDetail(title: 'アプリバージョン', detail: 'v1.0.0'),
            ],
          );
        },
      ),
    );
  }
}
