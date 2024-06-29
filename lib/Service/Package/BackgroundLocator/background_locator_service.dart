import 'dart:isolate';
import 'dart:ui';

import 'package:background_task/background_task.dart' as background_task;
import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../Constants/strings.dart';
import '../../../Model/Data/Warehouse/search_info_data.dart';
import '../../../Model/Data/location_data.dart';
import '../../../Model/Entity/Warehouse/search_info.dart';
import '../../../Model/Entity/location.dart';
import '../../API/Original/warehouse_service.dart';
import '../../Log/log_service.dart';

/// コールバックハンドラーを定義
/// バックグラウンドで位置情報を取得し、本流Isolateにメッセージを送信する
/// [data] 位置情報
Future<void> backgroundHandler(background_task.Location data) async {
  await dotenv.load(fileName: kDebugMode ? '.env.develop' : '.env.release');
  try {
    Log.echo('backgroundHandler: ${data.lat}, ${data.lng}', symbol: '📍');

    DateTime now = DateTime.now();
    Location currentLocation = LocationData().getData();

    /// 15秒以内の位置情報は無視する
    if (!now.isAfter(currentLocation.time.add(const Duration(seconds: 15)))) {
      return;
    }

    /// Locationをインスタンス化
    Location location = Location(
      lat: data.lat!,
      lng: data.lng!,
      time: now,
    );

    /// Androidの通知設定
    BackgroundLocatorService().setAndroidNotification(
      title: Strings.ANDROID_NOTIFICATION_TITLE,
      message: '${location.lat}, ${location.lng}',
    );

    /// BackgroundIsolate: 位置情報を更新
    LocationData().setData(data: location);
    Log.echo('backgroundHandler: LocationData updated', symbol: '🔄');

    /// BackgroundIsolate: APIに位置情報を送信
    WarehouseService warehouseService = WarehouseService();
    WarehouseSearchInfo? searchInfo =
        await warehouseService.searchWarehouseList(
      userLatitude: location.lat,
      userLongitude: location.lng,
    );
    if (searchInfo == null) {
      throw Exception('Search failed.');
    }
    Log.echo('backgroundHandler: API Success: $searchInfo', symbol: '📡');

    /// BackgroundIsolate: APIの結果を更新
    WarehouseSearchInfoData().setData(data: searchInfo);
    Log.echo('backgroundHandler: WarehouseSearchInfoData updated',
        symbol: '🔄');

    /// 本流Isolateのポートを取得
    SendPort? mainIsolateSendPort =
        IsolateNameServer.lookupPortByName('mainIsolate');

    if (mainIsolateSendPort == null) {
      Log.echo('backgroundHandler: mainIsolateSendPort is null', symbol: '🚪');
      return;
    }

    /// send用のデータを作成
    Map<String, dynamic> locationJson = location.toJson();
    Map<String, dynamic> searchInfoJson = searchInfo.toJson();

    /// 本流Isolateにメッセージを送信
    mainIsolateSendPort.send([
      locationJson,
      searchInfoJson,
    ]);
  } catch (e) {
    Log.echo('backgroundHandler: ${e.toString()}', symbol: '❌');
    await LocationData().setData(force: true);
  }
}

class BackgroundLocatorService {
  /// 初期設定
  Future<void> initialize() async {
    await background_task.BackgroundTask.instance
        .setBackgroundHandler(backgroundHandler);
    setAndroidNotification();
  }

  /// BackgroundLocatorからメッセージを受信するObserver
  void observer() {
    Log.echo('Observer watch start', symbol: '👀');

    /// ポートを登録
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, 'mainIsolate');

    /// メッセージを受信
    port.listen((message) async {
      Log.echo('Observer message received: $message', symbol: '📩');

      /// メッセージのデコード
      Location location = Location.fromJson(message[0]);
      WarehouseSearchInfo searchInfo = WarehouseSearchInfo.fromJson(message[1]);

      /// mainIsolate: 位置情報を更新
      LocationData().setData(data: location);
      Log.echo('Observer: LocationData updated', symbol: '🔄');

      /// mainIsolate: APIの結果を更新
      WarehouseSearchInfoData().setData(data: searchInfo);
      Log.echo('Observer: WarehouseSearchInfoData updated', symbol: '🔄');

      /// debug: isInvadingの強制
      if (kDebugMode) {
        SharedPreferencesService prefs = SharedPreferencesService();
        bool? forceInvadingMode = await prefs
            .getBool(SharedPreferencesKeysEnum.forceInvadingMode.name);
        bool? forceIsInvading =
            await prefs.getBool(SharedPreferencesKeysEnum.forceIsInvading.name);

        if (forceInvadingMode!) {
          WarehouseSearchInfoData().setIsInvading(forceIsInvading!);
          Log.echo('Observer: isInvading forced $forceIsInvading',
              symbol: '🚧');
        }
      }
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
    await LocationData().setData(force: true);
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
