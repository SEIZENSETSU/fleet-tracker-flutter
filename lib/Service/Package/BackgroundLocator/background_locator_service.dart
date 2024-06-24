import 'dart:isolate';
import 'dart:ui';

import 'package:background_task/background_task.dart' as background_task;
import 'package:fleet_tracker/Model/Data/location_data.dart';

import '../../../Constants/strings.dart';
import '../../../Model/Entity/location.dart';
import '../../Log/log_service.dart';

/// コールバックハンドラーを定義
/// バックグラウンドで位置情報を取得し、本流Isolateにメッセージを送信する
/// [data] 位置情報
Future<void> backgroundHandler(background_task.Location data) async {
  try {
    Log.echo('backgroundHandler: ${data.lat}, ${data.lng}', symbol: '📍');

    BackgroundLocatorService().setAndroidNotification(
      title: Strings.ANDROID_NOTIFICATION_TITLE,
      message: '${data.lat}, ${data.lng}',
    );

    /// send用のデータを作成
    Map<String, dynamic> locationData = {
      'lat': data.lat,
      'lng': data.lng,
      'time': DateTime.now().toIso8601String()
    };

    /// 本流Isolateにメッセージを送信
    SendPort? mainIsolateSendPort =
        IsolateNameServer.lookupPortByName('mainIsolate');
    mainIsolateSendPort?.send(locationData);
  } catch (e) {
    Log.echo('backgroundHandler: ${e.toString()}', symbol: '❌');
  }
}

class BackgroundLocatorService {
  /// 初期設定
  Future<void> initialize() async {
    await background_task.BackgroundTask.instance
        .setBackgroundHandler(backgroundHandler);
    setAndroidNotification();
    // await start();
  }

  /// BackgroundLocatorからメッセージを受信するObserver
  void observer() {
    Log.echo('Observer watch start', symbol: '👀');

    /// ポートを登録
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, 'mainIsolate');

    /// メッセージを受信
    port.listen((message) {
      Log.echo('backgroundLocatorService: $message', symbol: '🔊');

      /// 位置情報をデコード
      Location location = Location.fromJson(message);

      /// シングルトンに位置情報を保存
      LocationData().setData(location);
    });
  }

  /// Observerの破棄
  void dispose() {
    Log.echo('dispose', symbol: '🗑️');
    IsolateNameServer.removePortNameMapping('mainIsolate');
  }

  /// Androidの通知設定
  /// [title] 通知タイルのタイトル
  /// [message] 通知タイルの内容
  Future<void> setAndroidNotification({
    String title = Strings.ANDROID_NOTIFICATION_TITLE,
    String message = Strings.ANDROID_NOTIFICATION_MESSAGE,
  }) async {
    await background_task.BackgroundTask.instance.setAndroidNotification(
      title: title,
      message: message,
    );
  }

  /// バックグラウンドで位置情報の使用を開始
  Future<void> start() async {
    if (await background_task.BackgroundTask.instance.isRunning) {
      return;
    }
    await background_task.BackgroundTask.instance.start();
  }

  /// 停止
  Future<void> stop() async {
    await background_task.BackgroundTask.instance.stop();
  }
}
