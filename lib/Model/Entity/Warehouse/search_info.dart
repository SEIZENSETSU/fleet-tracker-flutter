import 'package:fleet_tracker/Model/Entity/Warehouse/area_search_info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/info.dart';

class WarehouseSearchInfo {
  bool isInvading;
  final List<WarehouseInfo>? warehouses;
  final List<WarehouseInfo> favoriteWarehouses;
  final List<WarehouseAreaSearchInfo>? warehouseAreas;

  WarehouseSearchInfo({
    required this.isInvading,
    this.warehouses,
    required this.favoriteWarehouses,
    this.warehouseAreas,
  });

  factory WarehouseSearchInfo.fromJson(Map<String, dynamic> json) {
    return WarehouseSearchInfo(
      isInvading: json['is_invading'],
      warehouses: json['warehouses']
          .map<WarehouseInfo>((x) => WarehouseInfo.fromJson(x))
          .toList(),
      favoriteWarehouses: json['favorite_warehouses']
          .map<WarehouseInfo>((x) => WarehouseInfo.fromJson(x))
          .toList(),
      warehouseAreas: json['warehouse_areas']
          .map<WarehouseAreaSearchInfo>(
              (x) => WarehouseAreaSearchInfo.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_invading': isInvading,
      'warehouses': warehouses!.map((x) => x.toJson()).toList(),
      'favorite_warehouses': favoriteWarehouses.map((x) => x.toJson()).toList(),
      'warehouse_areas': warehouseAreas!.map((x) => x.toJson()).toList(),
    };
  }
}
