import 'package:fleet_tracker/Model/Entity/Warehouse/area_search_info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/state.dart';

class WarehouseSearchInfo {
  final bool isInvading;
  final List<WarehouseState>? warehouses;
  final List<WarehouseState> favoriteWarehouses;
  final List<WarehouseAreaSearchInfo>? warehouseAreas;

  WarehouseSearchInfo({
    required this.isInvading,
    required this.warehouses,
    required this.favoriteWarehouses,
    required this.warehouseAreas,
  });

  factory WarehouseSearchInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return WarehouseSearchInfo(
      isInvading: json['is_invading'],
      warehouses: json['warehouses'].map<WarehouseState>((x) => WarehouseState.fromJson(x)).toList(),
      favoriteWarehouses: json['favorite_warehouses'].map<WarehouseState>((x) => WarehouseState.fromJson(x)).toList(),
      warehouseAreas: json['warehouse_areas'].map<WarehouseAreaSearchInfo>((x) => WarehouseAreaSearchInfo.fromJson(x)).toList(),
    );
  }
}
