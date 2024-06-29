import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/Service/API/Original/user_service.dart';
import 'package:fleet_tracker/Service/Firebase/Authentication/authentication_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/Entity/user.dart';
import '../Service/API/Original/warehouse_service.dart';
import '../Service/Log/log_service.dart';
import '../Service/Package/BackgroundLocator/background_locator_service.dart';
import '../Service/Package/local_notification/local_notifications_service.dart';
import '../View/Component/CustomWidget/Dialog/error_dialog.dart';

class TopLoadingController {
  FirebaseAuthenticationService get authenticationService =>
      FirebaseAuthenticationService();
  BackgroundLocatorService get backgroundLocatorService =>
      BackgroundLocatorService();
  WarehouseService get warehouseService => WarehouseService();
  UserService get userService => UserService();

  final BuildContext context;
  bool permissionStatus = false;

  TopLoadingController(this.context);

  Future<void> firstLoad() async {
    /// 画面を縦向きに固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    LocalNotificationsService().requestPermissions();

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
      throw Exception('Location permission denied');
    }

    /// 位置情報を取得
    Location location = LocationData().getData();

    /// 初回API通信
    WarehouseSearchInfo? searchInfo =
        await warehouseService.searchWarehouseList(
            userLatitude: location.lat, userLongitude: location.lng);
    if (searchInfo == null) {
      throw Exception('Search failed.');
    }

    /// 倉庫情報をシングルトンにSet
    WarehouseSearchInfoData().setData(data: searchInfo);

    /// ユーザー情報を取得
    firebase_auth.User? authUser = authenticationService.getUser();
    User? userInfo;
    if (authUser == null) {
      /// Firebase: 匿名ログイン
      firebase_auth.User? credential =
          await authenticationService.signInAnonymously();
      if (credential == null) {
        throw Exception('Firebase authentication failed');
      }

      /// API: ユーザー情報登録
      userInfo = await userService.registerUser(
        uid: credential.uid,
        userName: 'ドライバーさん',
        fcmTokenId: 'fcmTokenId',
      );
    } else {
      /// API: ユーザー情報取得
      userInfo = await userService.getUserInfo(uid: authUser.uid);
    }

    if (userInfo == null) {
      throw Exception('User information acquisition failed');
    }

    Log.toast(
      'FirebaseAuth: ${authUser == null ? '新規' : '登録済み'} (${userInfo.uid})',
    );

    /// ユーザー情報をシングルトンにSet
    UserData().setData(data: userInfo);

    await Future.delayed(const Duration(seconds: 1));
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
