import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';

import '../../Model/Entity/Warehouse/warehouse.dart';

class UserInputCellController {
  /// USerInputCellに使用する遅延状態の平均値を取得する
  /// [warehouseId]
  Future<String?> getAverageDelayState({required warehouseId}) async {
    String? average;
    Warehouse? warehouse =
        await WarehouseService().getWarehouseInfo(warehouseId: warehouseId);

    if (warehouse == null) {
      // エラー
      return null;
    }
    WarehouseSearchInfo? searchInfo = await WarehouseService()
        .searchWarehouseList(
            userLatitude: warehouse.latitude,
            userLongitude: warehouse.longitude);
    if (searchInfo == null) {
      // エラー
      return null;
    }
    final info = searchInfo.warehouses!
        .firstWhere((element) => element.warehouseId == warehouseId);
    average = info.averageDelayState.name;

    return average;
  }
}
