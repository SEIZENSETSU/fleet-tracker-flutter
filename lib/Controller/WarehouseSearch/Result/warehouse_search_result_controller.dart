import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/warehouse.dart';
import 'package:fleet_tracker/Model/Entity/local_area.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';

import '../../../Model/Entity/Warehouse/info.dart';

class WarehouseSearchResultController {
  /// キーワードから工場一覧を取得する
  /// [keyword]
  Future<List<Warehouse>?> getWarehouseWithKeyword(
      {required String keyword}) async {
    List<Warehouse>? warehouseList = [];
    for (int i = 1; i < 10; i++) {
      List<Warehouse>? searchWarehouse =
          await WarehouseService().getWarehouseList(i);
      if (searchWarehouse != null) {
        warehouseList.addAll(searchWarehouse);
      }
    }
    List<Warehouse> sortList =
        warehouseList.where((e) => e.name.contains(keyword)).toList();
    Log.echo(sortList.toString());
    return sortList;
  }

  /// エリアID(List許容)から工場一覧を取得する
  /// [areaIds]
  Future<List<Warehouse>?> getWarehouseWithArea(
      {required List<int> areaIds}) async {
    List<Warehouse>? warehouseList = [];
    for (int i = 0; i < areaIds.length; i++) {
      List<Warehouse>? searchWarehouse =
          await WarehouseService().getWarehouseList(areaIds[i]);
      if (searchWarehouse != null) {
        warehouseList.addAll(searchWarehouse);
      }
    }
    return warehouseList;
  }

  /// 倉庫ページに遷移するための情報を取得
  /// [warehouseId]
  Future<WarehouseInfo?> getWarehouseInfo({required int warehouseId}) async {
    WarehouseInfo? warehouseInfo;
    final warehouse =
        await WarehouseService().getWarehouseInfo(warehouseId: warehouseId);
    if (warehouse == null) {
      // エラー
      return null;
    }
    final searchInfo = await WarehouseService().searchWarehouseList(
      userLatitude: warehouse.latitude,
      userLongitude: warehouse.longitude,
    );
    if (searchInfo == null) {
      // エラー
      return null;
    }
    warehouseInfo = searchInfo.warehouses!
        .firstWhere((element) => element.warehouseId == warehouseId);

    return warehouseInfo;
  }
}
