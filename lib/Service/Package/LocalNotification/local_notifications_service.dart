import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationsService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// フォアグラウンド設定とパーミッションを行うInitialize
  Future<void> initialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // ...
      },
    );
    await requestPermissions();
  }

  /// 通知のパーミッション
  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: false,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  /// 通知バーの設定
  /// [title] 通知のタイトル
  /// [body] 通知の内容
  Future<void> showNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const iosNotificationDetail = DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'item x',
    );
  }

  /// 通知の状態を返す
  Future<bool> checkNotificationPermission() async {
    PermissionStatus permissionStatus = await Permission.notification.status;
    if (permissionStatus.isGranted) {
      return true;
    }
    return false;
  }

  /// 通知のオン
  Future<void> requestNotificationPermission() async {
    PermissionStatus permissionStatus = await Permission.notification.status;
    if (permissionStatus.isDenied ||
        permissionStatus.isRestricted ||
        permissionStatus.isPermanentlyDenied) {
      await Permission.notification.request();
    }
  }

  /// 通知のオフ
  Future<void> cancel() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
