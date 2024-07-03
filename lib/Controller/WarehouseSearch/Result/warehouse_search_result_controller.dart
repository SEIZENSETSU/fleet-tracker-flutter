import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/warehouse.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';

import '../../../Model/Entity/Warehouse/info.dart';

class WarehouseSearchResultController {
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
  Future<WarehouseInfo?> getWarehouseInfo({required warehouseId}) async {
    WarehouseInfo? warehouseInfo;
    final warehouse =
        await WarehouseService().getWarehouseInfo(warehouseId: warehouseId);
    if (warehouse == null) {
      // エラー
      return null;
    }
    final searchInfo = await WarehouseService().searchWarehouseList(
      userLatitude: warehouse!.latitude,
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
