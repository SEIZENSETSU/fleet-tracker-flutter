import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Service/Log/log_service.dart';
import '../Service/Package/BackgroundLocator/background_locator_service.dart';
import '../View/Component/CustomWidget/Dialog/error_dialog.dart';

class TopLoadingController {
  BackgroundLocatorService backgroundLocatorService =
      BackgroundLocatorService();

  final BuildContext context;
  bool permissionStatus = false;

  TopLoadingController(this.context);

  Future<void> firstLoad() async {
    /// 画面を縦向きに固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    permissionStatus = await checkLocationPermission();
    if (!permissionStatus) {
      ErrorDialog().showErrorDialog(
        context: context,
        title: 'エラー',
        content: const CustomText(text: 'エラーが発生しました'),
        detail: '位置情報の許可が必要です',
        buttonAction: () {
          SystemNavigator.pop();
        },
      );
      return;
    }

    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
    // ignore: use_build_context_synchronously, prefer_const_constructors
    HomeRoute().go(context);
  }

  /// 位置情報の許可を確認する関数
  Future<bool> checkLocationPermission() async {
    Log.echo('checkLocationPermission', symbol: '🔍');
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      PermissionStatus newStatus = await Permission.location.request();

      if (newStatus.isDenied ||
          newStatus.isRestricted ||
          newStatus.isPermanentlyDenied) {
        Fluttertoast.showToast(msg: '位置情報の許可が必要です');
        return false;
      }
    }

    /// BackgroundLocatorServiceを開始
    backgroundLocatorService.start();
    return true;
  }
}
