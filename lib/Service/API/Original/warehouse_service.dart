import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Model/Entity/warehouse.dart';
import '../../Log/log_service.dart';

abstract class BaseWarehouseService {
  late String baseUrl;
  late http.Response response;
  late Uri uri;
  final Map<String, String> headers = {'Content-type': 'application/json'};

  //倉庫情報取得
  Future<Warehouse?> getWarehouseInfo({required int warehouse_id}) async {
    uri = Uri.https(baseUrl, '/warehouse', {'warehouse_id': warehouse_id.toString()});

    try {
      response = await http.get(uri);
      if (response.statusCode != 200) {
        Log.echo('データを取得できませんでした');
        return null;
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Warehouse warehouse = Warehouse(
        warehouse_id: jsonResponse['warehouse_id'],
        warehouse_area_id: jsonResponse['warehouse_area_id'],
        warehouse_name: jsonResponse['warehouse_name'],
        warehouse_latitude: jsonResponse['warehouse_latitude'],
        warehouse_longitude: jsonResponse['warehouse_longitude'],
      );
      Log.echo('取得成功');
      return warehouse;
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました $e');
      return null;
    }
  }

  //倉庫一覧情報取得
  Future<List<Warehouse?>?> getWarehouseList(int warehouse_area_id) async {
    uri = Uri.https(baseUrl, '/warehouses', {'warehouse_area_id': warehouse_area_id.toString()});

    try {
      response = await http.get(uri);
      if (response.statusCode != 200) {
        Log.echo('データを取得できませんでした');
        return null;
      }
      List<Warehouse?> warehouseList = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (dynamic warehouseData in jsonResponse) {
        Warehouse warehouse = Warehouse(
          warehouse_id: warehouseData['warehouse_id'],
          warehouse_area_id: warehouseData['warehouse_area_id'],
          warehouse_name: warehouseData['warehouse_name'],
          warehouse_latitude: warehouseData['warehouse_latitude'],
          warehouse_longitude: warehouseData['warehouse_longitude'],
        );
        warehouseList.add(warehouse);
      }
      Log.echo('取得成功');
      return warehouseList;
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました $e');
      return null;
    }
  }

  //倉庫検索
  Future<Map<String, dynamic>?> searchWarehouseList({int? favorite_warehouse_ids, required double user_latitude, required double user_longitude}) async {
    Map<String, String> queryParams = {
      'user_latitude': user_latitude.toString(),
      'user_longitude': user_longitude.toString(),
    };

    if (favorite_warehouse_ids != null && favorite_warehouse_ids != 0) {
      queryParams['favorite_warehouse_ids'] = favorite_warehouse_ids.toString();
    }

    Uri uri = Uri.https(baseUrl, '/warehouses/search', queryParams);

    try {
      response = await http.get(uri);
      if (response.statusCode != 200) {
        Log.echo('データを取得できませんでした');
        return null;
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Log.echo('取得成功');
      Log.echo(jsonResponse['warehouses'][0]['warehouse_name']);
      return jsonResponse;
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました $e');
      return null;
    }
  }
}

//Mock用
class MockWarehouseService extends BaseWarehouseService {
  MockWarehouseService() {
    baseUrl = 'fleet-tracker-api-docs-tnvlhcq2ja-uc.a.run.app';
  }
}

//本番用
class ProdWarehouseService extends BaseWarehouseService {
  ProdWarehouseService() {
    baseUrl = 'HONBAN.com';
  }
}
