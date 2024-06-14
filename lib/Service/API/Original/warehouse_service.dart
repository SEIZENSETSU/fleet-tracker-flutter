import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/warehouse.dart';

class WarehouseService {
  //MOCK VER WarehouseIdから倉庫情報を取得
  Future<Warehouse?> mockGetWarehouseInfo(int warehouse_id) async {
    Uri url = Uri.parse('https://api.letsbuildthatapp.com/youtube/home_feed');
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Warehouse warehouse = Warehouse(
        warehouse_id: jsonResponse['warehouse_id'],
        warehouse_area_id: jsonResponse['warehouse_area_id'],
        warehouse_name: jsonResponse['warehouse_name'],
        warehouse_latitude: jsonResponse['warehouse_latitude'],
        warehouse_longitude: jsonResponse['warehouse_longitude'],
      );
      return warehouse;
    } else {
      return null;
    }
  }

  //MOCK VER WarehouseAreaIdから倉庫情報を取得
  Future<List<Warehouse?>?> mockGetWarehouseList(int warehouse_area_id) async {
    Uri url = Uri.parse('https://api.letsbuildthatapp.com/youtube/home_feed');
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<Warehouse?> warehouseList = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        Warehouse warehouse = Warehouse(
          warehouse_id: jsonResponse[i]['warehouse_id'],
          warehouse_area_id: jsonResponse[i]['warehouse_area_id'],
          warehouse_name: jsonResponse[i]['warehouse_name'],
          warehouse_latitude: jsonResponse[i]['warehouse_latitude'],
          warehouse_longitude: jsonResponse[i]['warehouse_longitude'],
        );
        warehouseList.add(warehouse);
      }
      return warehouseList;
    } else {
      return null;
    }
  }
}
