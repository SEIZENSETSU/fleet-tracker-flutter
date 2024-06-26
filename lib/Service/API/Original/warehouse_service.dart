import 'dart:convert';

import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/local_area.dart';
import 'package:fleet_tracker/Service/Firebase/Authentication/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Entity/Warehouse/warehouse.dart';
import '../../Log/log_service.dart';

class WarehouseService {
  FirebaseAuthenticationService get authService => FirebaseAuthenticationService();
  late String baseUrl;

  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  WarehouseService() {
    baseUrl = dotenv.env['FLEET_TRACKER_API_BASEURL']!;
  }

  /// 倉庫情報取得
  /// [warehouseId] 倉庫ID
  Future<Warehouse?> getWarehouseInfo({required int warehouseId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/warehouse',
      {'warehouse_id': '$warehouseId'},
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(responseUtf8);

      Warehouse warehouse = Warehouse.fromJson(jsonResponse);

      Log.echo('取得成功');
      return warehouse;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// 倉庫一覧情報取得
  /// [warehouseAreaId] 倉庫エリアID
  Future<List<Warehouse>?> getWarehouseList(int warehouseAreaId) async {
    Uri uri = Uri.https(
      baseUrl,
      '/warehouses',
      {'warehouse_area_id': '$warehouseAreaId'},
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      List<dynamic> jsonResponse = json.decode(responseUtf8);

      List<Warehouse> warehouseList = [];
      for (dynamic warehouseData in jsonResponse) {
        Warehouse warehouse = Warehouse.fromJson(warehouseData);
        warehouseList.add(warehouse);
      }

      Log.echo('取得成功');
      return warehouseList;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// 倉庫検索
  /// [favoriteWarehouseIds] お気に入り倉庫ID
  /// [userLatitude] ユーザー緯度
  /// [userLongitude] ユーザー経度
  Future<WarehouseSearchInfo?> searchWarehouseList({
    int? favoriteWarehouseIds,
    required double userLatitude,
    required double userLongitude,
  }) async {
    Map<String, String> queryParams = {
      'user_latitude': '$userLatitude',
      'user_longitude': '$userLongitude',
    };

    if (favoriteWarehouseIds != null && favoriteWarehouseIds != 0) {
      queryParams['favorite_warehouse_ids'] = '$favoriteWarehouseIds';
    }

    Uri uri = Uri.https(
      baseUrl,
      '/warehouses/search',
      queryParams,
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(responseUtf8);

      WarehouseSearchInfo warehouseSearchInfo = WarehouseSearchInfo.fromJson(jsonResponse);
      Log.echo('取得成功');
      return warehouseSearchInfo;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// 倉庫遅延情報取得
  Future<List<LocalArea>?> getLocalAreaList() async {
    Uri uri = Uri.https(
      baseUrl,
      '/areas/warehouses',
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      List<dynamic> jsonResponse = json.decode(responseUtf8);

      List<LocalArea> localAreaList = [];
      for (dynamic localAreaData in jsonResponse) {
        LocalArea localArea = LocalArea.fromJson(localAreaData);
        localAreaList.add(localArea);
      }

      Log.echo('取得成功');
      return localAreaList;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
