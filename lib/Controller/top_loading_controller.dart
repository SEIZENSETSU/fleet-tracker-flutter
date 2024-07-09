// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/WarehouseSearch/warehouse_search_top_controller.dart';
import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/Service/API/Original/user_service.dart';
import 'package:fleet_tracker/Service/Firebase/Authentication/authentication_service.dart';
import 'package:fleet_tracker/Service/Firebase/RemoteConfig/remote_config_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Constants/Enum/remote_config_keys_enum.dart';
import '../Model/Entity/user.dart';
import '../Service/API/Original/warehouse_service.dart';
import '../Service/Log/log_service.dart';
import '../Service/Package/BackgroundLocator/background_locator_service.dart';
import '../Service/Package/LocalNotification/local_notifications_service.dart';
import '../View/Component/CustomWidget/Dialog/custom_dialog.dart';

class TopLoadingController {
  FirebaseAuthenticationService get authenticationService =>
      FirebaseAuthenticationService();
  BackgroundLocatorService get backgroundLocatorService =>
      BackgroundLocatorService();
  WarehouseService get warehouseService => WarehouseService();
  UserService get userService => UserService();

  final BuildContext context;
  bool notificationPermissionStatus = false;
  bool locationPermissionStatus = false;

  TopLoadingController(this.context);

  Future<void> firstLoad() async {
    /// 画面を縦向きに固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    /// RemoteConfig Initialize
    await RemoteConfigService().initalize();

    bool releaseValue = RemoteConfigService().getBool(RemoteConfigKeys.release);
    if (!releaseValue) {
      final completer = Completer<void>();
      CustomDialog().showCustomDialog(
        context: context,
        title: 'メンテナンス中です...',
        content: Assets.images.icons.errorDialogIcon.image(),
        detail: '時間を開けて再度起動してください。',
        isShowButton: false,
      );
      return completer.future;
    }

    /// LocalNotifications Initialize
    await LocalNotificationsService().initialize();

    notificationPermissionStatus = await checkNotificationPermission();

    Log.echo('SharedPreferences Initialize', symbol: '🔍');

    /// SharedPreferences Initialize
    SharedPreferencesService prefs = SharedPreferencesService();
    if (kDebugMode) {
      await prefs.getBool(SharedPreferencesKeysEnum.forceInvadingMode.name) ??
          prefs.setBool(
              SharedPreferencesKeysEnum.forceInvadingMode.name, false);
      await prefs.getBool(SharedPreferencesKeysEnum.forceIsInvading.name) ??
          prefs.setBool(SharedPreferencesKeysEnum.forceIsInvading.name, false);
    }

    /// 初回起動フラグを初期化
    await prefs.getBool(SharedPreferencesKeysEnum.isFirstBoot.name) ??
        prefs.setBool(SharedPreferencesKeysEnum.isFirstBoot.name, true);

    /// お気に入り倉庫リストを初期化
    await prefs.getStringList(
            SharedPreferencesKeysEnum.favoriteWarehouseList.name) ??
        prefs.setStringList(
            SharedPreferencesKeysEnum.favoriteWarehouseList.name, []);

    /// 通知設定を初期化
    await prefs.getBool(SharedPreferencesKeysEnum.sendInputNotification.name) ??
        prefs.setBool(
            SharedPreferencesKeysEnum.sendInputNotification.name, true);
    await prefs
            .getBool(SharedPreferencesKeysEnum.sendHighwayNotification.name) ??
        prefs.setBool(
            SharedPreferencesKeysEnum.sendHighwayNotification.name, true);
    await prefs.getBool(SharedPreferencesKeysEnum.areaSwitch.name) ??
        prefs.setBool(SharedPreferencesKeysEnum.areaSwitch.name, true);
    await prefs.getBool(SharedPreferencesKeysEnum.delaySwitch.name) ??
        prefs.setBool(SharedPreferencesKeysEnum.delaySwitch.name, true);

    /// 倉庫検索タブのview切り替え取得
    bool? mapSwitch =
        await prefs.getBool(SharedPreferencesKeysEnum.mapSwitch.name);
    if (mapSwitch == null) {
      await WarehouseSearchTopController().setMapSwitch(flag: true);
    } else {
      await WarehouseSearchTopController().setMapSwitch(flag: mapSwitch);
    }

    /// 利用規約ダイアログの表示
    bool isFirstBoot =
        await prefs.getBool(SharedPreferencesKeysEnum.isFirstBoot.name) ??
            false;
    if (isFirstBoot) {
      final completer = Completer<void>();
      await CustomDialog().showCustomDialog(
        context: context,
        title: '利用規約',
        content: const Icon(Icons.info_outline_rounded, color: Colors.blue),
        detail: '利用規約を確認してください。',
        buttonText: '確認しました',
        detailLink: 'https://sei-zen-setsu.web.app/terms_of_service.html',
        buttonAction: () {
          completer.complete();
          Navigator.of(
            context,
            rootNavigator: true,
          ).pop();
        },
      );
      await completer.future;
    }

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
        userName: '名無しのドライバー',
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

    locationPermissionStatus = await checkLocationPermission();

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

    await Future.delayed(const Duration(seconds: 1));

    if (isFirstBoot) {
      TutorialRoute().go(context);
      return;
    }

    // ignore: prefer_const_constructors
    HomeRoute().go(context);
  }

  /// 通知の許可を確認する関数
  Future<bool> checkNotificationPermission() async {
    Log.echo('checkNotificationPermission', symbol: '🔍');
    PermissionStatus status = await Permission.notification.status;

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      final completer = Completer<void>();
      CustomDialog().showCustomDialog(
        context: context,
        title: '通知を利用します',
        content: const Icon(Icons.info_outline_rounded, color: Colors.blue),
        detail: 'アプリがバックグラウンドで実行中でも、サービス提供のために通知を使用します。「常に許可」を選択してください。',
        buttonText: '確認',
        buttonAction: () {
          completer.complete();
          Navigator.of(
            context,
            rootNavigator: true,
          ).pop();
        },
      );
      await completer.future;

      PermissionStatus newStatus =
          await LocalNotificationsService().requestPermissions();

      if (newStatus.isDenied ||
          newStatus.isRestricted ||
          newStatus.isPermanentlyDenied) {
        Fluttertoast.showToast(msg: '通知の許可が必要です');
        return false;
      }
    }

    return true;
  }

  /// 位置情報の許可を確認する関数
  Future<bool> checkLocationPermission() async {
    Log.echo('checkLocationPermission', symbol: '🔍');
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      final completer = Completer<void>();
      CustomDialog().showCustomDialog(
        context: context,
        title: '位置情報を利用します',
        content: const Icon(Icons.info_outline_rounded, color: Colors.blue),
        detail:
            'アプリがバックグラウンドで実行中でも、サービス提供のために位置情報を使用します。「アプリの起動中は許可」を選択してください。',
        buttonText: '確認',
        buttonAction: () {
          completer.complete();
          Navigator.of(
            context,
            rootNavigator: true,
          ).pop();
        },
      );
      await completer.future;

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
