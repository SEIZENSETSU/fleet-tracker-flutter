import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Entity/local_area.dart';
import '../../../Model/Entity/warehouse.dart';
import '../../Log/log_service.dart';

class WarehouseService {
  late String baseUrl;

  final Map<String, String> headers = {'Content-type': 'application/json'};

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
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

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
  Future<List<Warehouse?>?> getWarehouseList(int warehouseAreaId) async {
    Uri uri = Uri.https(
      baseUrl,
      '/warehouses',
      {'warehouse_area_id': '$warehouseAreaId'},
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      List<dynamic> jsonResponse = json.decode(response.body);

      List<Warehouse?> warehouseList = [];
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
  Future<Map<String, dynamic>?> searchWarehouseList({
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

    Uri uri = Uri.https(baseUrl, '/warehouses/search', queryParams);

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      Log.echo('取得成功');
      Log.echo(jsonResponse['warehouses'][0]['warehouse_name']);
      return jsonResponse;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// ローカルエリアおよび倉庫エリアでグループ化された倉庫の一覧情報を取得
  Future<List<LocalArea>?> getLocalAreaList() async {
    Uri uri = Uri.https(
      baseUrl,
      '/areas/warehouses',
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      List<dynamic> jsonResponse = json.decode(response.body);

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
