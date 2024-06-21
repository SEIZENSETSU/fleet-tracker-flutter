import 'package:background_task/background_task.dart';

import '../../../Constants/strings.dart';
import '../../Log/log_service.dart';

/// コールバックハンドラーを定義
Future<void> backgroundHandler(Location data) async {
  Log.echo('🍑backgroundHandler: ${DateTime.now()}, $data');
}

class BackgroundLocatorService {
  ///初期設定
  Future<void> initialize() async {
    BackgroundTask.instance.setBackgroundHandler(backgroundHandler);
    setAndroidNotification();
    start();
  }

  ///Androidの通知設定
  ///【title】通知タイルのタイトル
  ///【message】通知タイルの内容
  Future<void> setAndroidNotification({
    String title = Strings.ANDROID_NOTIFICATION_TITLE,
    String message = Strings.ANDROID_NOTIFICATION_MESSAGE,
  }) async {
    await BackgroundTask.instance.setAndroidNotification(
      title: title,
      message: message,
    );
  }

  /// バックグラウンドで位置情報の使用を開始
  Future<void> start() async {
    await BackgroundTask.instance.start();
  }

  ///停止
  Future<void> stop() async {
    await BackgroundTask.instance.stop();
  }
}
