import 'package:fleet_tracker/Model/Entity/Warehouse/warehouse.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';

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
}
