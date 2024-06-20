import 'package:background_task/background_task.dart';

import '../../../Constants/strings.dart';
import '../../Log/log_service.dart';

class BackgroundLocatorService {
  //初期設定
  Future<void> initialize() async {
    BackgroundTask.instance.setBackgroundHandler(backgroundHandler);
    setAndroidNotification();
  }

  // 位置情報が検知されると発火する
  Future<void> backgroundHandler(Location data) async {
    //ここが動く
    Log.echo('🍑backgroundHandler: ${DateTime.now()}, $data');
  }

  //Androidの通知設定
  Future<void> setAndroidNotification({
    String title = Strings.ANDROID_NOTIFICATION_TITLE,
    String message = Strings.ANDROID_NOTIFICATION_MESSAGE,
  }) async {
    await BackgroundTask.instance.setAndroidNotification(
      title: title,
      message: message,
    );
  }

  // バックグラウンドで位置情報の使用を開始
  Future<void> start() async {
    await BackgroundTask.instance.start();
  }

  //停止
  Future<void> stop() async {
    await BackgroundTask.instance.stop();
  }
}
