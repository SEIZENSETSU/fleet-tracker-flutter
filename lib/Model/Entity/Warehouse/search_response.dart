import 'package:fleet_tracker/Model/Entity/Warehouse/area_search_response.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/state.dart';

class WarehouseSearchResponse {
  final bool isInvading;
  final List<WarehouseState> warehouses;
  final List<WarehouseState> favoriteWarehouses;
  final List<WarehouseAreaSearchResponse> warehouseAreas;

  WarehouseSearchResponse({
    required this.isInvading,
    required this.warehouses,
    required this.favoriteWarehouses,
    required this.warehouseAreas,
  });

  factory WarehouseSearchResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return WarehouseSearchResponse(
      isInvading: json['is_invading'],
      warehouses: json['warehouses'].map<WarehouseState>((x) => WarehouseState.fromJson(x)).toList(),
      favoriteWarehouses: json['favorite_warehouses'].map<WarehouseState>((x) => WarehouseState.fromJson(x)).toList(),
      warehouseAreas: json['warehouse_areas'].map<WarehouseAreaSearchResponse>((x) => WarehouseAreaSearchResponse.fromJson(x)).toList(),
    );
  }
}
