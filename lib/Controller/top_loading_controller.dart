import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Service/API/Original/warehouse_service.dart';
import '../Service/Log/log_service.dart';
import '../Service/Package/BackgroundLocator/background_locator_service.dart';
import '../View/Component/CustomWidget/Dialog/error_dialog.dart';

class TopLoadingController {
  BackgroundLocatorService get backgroundLocatorService =>
      BackgroundLocatorService();
  WarehouseService get warehouseService => WarehouseService();
  SharedPreferencesService pref = SharedPreferencesService();

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
        content: const Placeholder(),
        detail: '位置情報の許可が必要です',
        buttonAction: () {
          SystemNavigator.pop();
        },
      );
      return;
    }

    /// 位置情報を取得
    Location location = LocationData().getData();

    /// shred_prefernce チェック
    final isJapanMapDeformed = await pref.getBool('isJapanMapDeformed') ?? true;
    pref.setBool('isJapanMapDeformed', isJapanMapDeformed);

    /// 初回API通信
    WarehouseSearchInfo? searchInfo =
        await warehouseService.searchWarehouseList(
            userLatitude: location.lat, userLongitude: location.lng);
    if (searchInfo == null) {
      Log.toast('倉庫情報の取得に失敗しました');

      /// todo: エラーダイアログを表示
      return;
    }

    /// 倉庫情報をシングルトンにSet
    WarehouseSearchInfoData().setData(data: searchInfo);

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

    /// シングルトンに位置情報を強制的にSetする
    await LocationData().setData(force: true);

    /// BackgroundLocatorServiceを開始
    backgroundLocatorService.start();
    return true;
  }
}
