import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:fleet_tracker/Service/API/Original/user_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/Entity/user.dart';
import '../../Service/Firebase/Authentication/authentication_service.dart';
import '../../Service/Log/log_service.dart';
import '../../Service/Package/LocalNotification/local_notifications_service.dart';
import '../../View/Component/CustomWidget/Modal/custom_modal.dart';
import '../../View/Component/CustomWidget/Modal/debug_modal.dart';
import '../../View/Component/CustomWidget/custom_button.dart';
import '../../gen/colors.gen.dart';

class SettingTopController {
  InAppReview get _inAppReview => InAppReview.instance;
  final TextEditingController textEditingController = TextEditingController();
  bool delaySwitch = true;
  String? userName;
  bool? areaSwitchValue;
  bool? delaySwitchValue;

  /// 名前変更のモーダル
  /// [userName] ユーザー名
  showReNameModal({
    required BuildContext context,
    required String userName,
    required Size size,
  }) {
    CustomModal().showModal(
      context: context,
      size: size,
      title: 'ユーザー名変更',
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 24),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'ユーザー名',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      //モーダルの中にCustomTextfieldを使うと落ちる
                      //わけがわからないので巻き取ってください
                      // CustomTextfield(
                      //   hintText: '',
                      //   backgroundcolor: Colors.white,
                      //   controller: textEditingController,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: CustomButton(
                    isFilledColor: true,
                    primaryColor: ColorName.mainthemeColor,
                    text: '変更',
                    onTap: () {
                      UserService().updateUser(
                        uid: FirebaseAuthenticationService().getUid()!,
                        userName: userName,
                        fcmTokenId: '',
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
    return await LocalNotificationsService().checkNotificationPermission();
  }

  /// エリア通知スイッチの動作
  Future<void> actionAreaSwitch({required bool value}) async {
    if (value) {
      LocalNotificationsService().requestPermissions();
    } else {
      LocalNotificationsService().cancel();
    }
  }

  /// 遅延通知スイッチの初期値
  Future<bool> getDelaySwitchValue() async {
    return await LocalNotificationsService().checkNotificationPermission();
  }

  /// 通知パーミッションのリクエスト
  Future<void> requestPermissions() async {
    await LocalNotificationsService().requestPermissions();
  }

  /// 通知パーミッションのキャンセル
  Future<void> cancel() async {
    await LocalNotificationsService().cancel();
  }

  /// レビューへ
  Future<void> openReview() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.openStoreListing(
        appStoreId: '',
      );
    }
  }

  /// googleformへ
  Future<void> openinquiry() async {
    Uri url = Uri.parse('https://forms.gle/ttQxZC2cBCT8VcSE6');
    if (!(await canLaunchUrl(url))) {
      Log.echo('URLを開けませんでした。', symbol: '❌');
      return;
    }
    await launchUrl(url);
  }
}
