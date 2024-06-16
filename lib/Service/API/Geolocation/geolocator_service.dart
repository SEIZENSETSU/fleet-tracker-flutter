import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<bool> isGeolocationServiceEnabled() async {
    // デバイスの位置情報サービスが有効かどうかチェック
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    // 位置情報を取得する許可チェック
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // ユーザーに「位置情報を許可しますか？」表示
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 拒否
        return false;
      }
    }
    // 永久に拒否されている場合のエラーを返す
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    // ここまでくれば位置情報系の権限は大丈夫
    return true;
  }

  Future getCurrentPosition() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();
      return currentPosition;
    } catch (e) {
      return null;
    }
  }
}
