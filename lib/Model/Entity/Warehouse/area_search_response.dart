import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';

class WarehouseAreaSearchResponse {
  final int warehouseAreaId;
  final String warehouseAreaName;
  final WarehouseDelayState averageDelayState;
  final int distance;

  WarehouseAreaSearchResponse({
    required this.warehouseAreaId,
    required this.warehouseAreaName,
    required this.averageDelayState,
    required this.distance,
  });

  factory WarehouseAreaSearchResponse.fromJson(Map<String, dynamic> json) {
    return WarehouseAreaSearchResponse(
      warehouseAreaId: json['warehouse_area_id'],
      warehouseAreaName: json['warehouse_area_name'],
      averageDelayState: WarehouseDelayStateType(json['average_delay_state']).type,
      distance: json['distance'],
    );
  }
}
