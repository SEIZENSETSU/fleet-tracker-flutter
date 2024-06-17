import 'package:background_task/background_task.dart';
import 'package:flutter/material.dart';

class BackgroundLocatorService {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    BackgroundTask.instance
        .setBackgroundHandler(BackgroundLocatorService().backgroundHandler);
  }

  Future<void> backgroundHandler(Location data) async {
    //ここが動く
    debugPrint('🍑backgroundHandler: ${DateTime.now()}, $data');
  }

  Future<void> androidNotification() async {
    await BackgroundTask.instance.setAndroidNotification(
      title: 'バックグラウンド処理',
      message: 'バックグラウンド処理を実行中',
    );
  }
}
