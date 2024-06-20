import 'package:background_task/background_task.dart';
import 'package:flutter/material.dart';

import '../../Log/log_service.dart';

class BackgroundLocatorService {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    BackgroundTask.instance.setBackgroundHandler(backgroundHandler);
    setAndroidNotification(
      title: 'バックグラウンド処理',
      message: 'バックグラウンド処理を実行中',
    );
  }

  // 位置情報が検知されると発火する
  Future<void> backgroundHandler(Location data) async {
    //ここが動く
    Log.echo('🍑backgroundHandler: ${DateTime.now()}, $data');
  }

  //Androidの通知設定
  Future<void> setAndroidNotification({
    required String title,
    required String message,
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
