import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants/Enum/shared_preferences_keys_enum.dart';
import '../../Model/Entity/user.dart';
import '../../Service/Log/log_service.dart';
import '../../Service/Package/LocalNotification/local_notifications_service.dart';
import '../../Service/Package/SharedPreferences/shared_preferences_service.dart';
import '../../View/Component/CustomWidget/Modal/debug_modal.dart';
import '../../View/Component/CustomWidget/Modal/rename_modal.dart';

class SettingTopController {
  InAppReview get _inAppReview => InAppReview.instance;
  bool delaySwitch = true;
  String? userName;
  bool? areaSwitchValue;
  bool? delaySwitchValue;

  /// 名前変更のモーダル
  showReNameModal({
    required BuildContext context,
    required Size size,
  }) {
    RenameModal().showReNameModal(
      context: context,
      userName: userName!,
      size: size,
    );
  }

  showDebugModal({
    required BuildContext context,
    required Size size,
  }) {
    DebugModal().showModal(
      context: context,
      size: size,
    );
  }

  /// 設定画面のinit
  Future<void> init() async {
    userName = await getUserName();
    areaSwitchValue = await getAreaSwitchValue();
    delaySwitchValue = await getAreaSwitchValue();
  }

  /// ユーザーネーム取得
  /// [uid] ユーザーid
  Future<String?> getUserName() async {
    User? userInfo = UserData().getData();
    return userInfo.name;
  }

  /// エリア通知スイッチの初期値
  Future<bool> getAreaSwitchValue() async {
    return await SharedPreferencesService()
            .getBool(SharedPreferencesKeysEnum.areaSwitch.name) ??
        true;
  }

  /// エリア通知スイッチの動作
  Future<void> actionAreaSwitch({required bool value}) async {
    await SharedPreferencesService()
        .setBool(SharedPreferencesKeysEnum.areaSwitch.name, value);
  }

  /// 遅延通知スイッチの初期値
  Future<bool> getDelaySwitchValue() async {
    return await SharedPreferencesService()
            .getBool(SharedPreferencesKeysEnum.delaySwitch.name) ??
        true;
  }

  /// エリア通知スイッチの動作
  Future<void> actionDelaySwitch({required bool value}) async {
    await SharedPreferencesService()
        .setBool(SharedPreferencesKeysEnum.delaySwitch.name, value);
  }

  /// レビューへ
  Future<void> openReview() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.openStoreListing(
        appStoreId: '6503596268',
      );
    }
  }

  /// googleformへ
  Future<void> openinquiry() async {
    Uri url = Uri.parse('https://forms.gle/CLn1SfQqQdHLjEiK9');
    if (!(await canLaunchUrl(url))) {
      Log.echo('URLを開けませんでした。', symbol: '❌');
      return;
    }
    await launchUrl(url);
  }
}
