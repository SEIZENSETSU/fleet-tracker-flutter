import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/delay.dart';

class WarehouseState {
  final int warehouseId;
  final int warehouseAreaId;
  final String warehouseName;
  final WarehouseDelayState averageDelayState;
  final List<WarehouseDelay> delayTimeDetail;
  final int distance;

  WarehouseState({
    required this.warehouseId,
    required this.warehouseAreaId,
    required this.warehouseName,
    required this.averageDelayState,
    required this.delayTimeDetail,
    required this.distance,
  });

  factory WarehouseState.fromJson(Map<String, dynamic> json) {
    return WarehouseState(
      warehouseId: json['warehouse_id'],
      warehouseAreaId: json['warehouse_area_id'],
      warehouseName: json['warehouse_name'],
      averageDelayState: WarehouseDelayStateType(json['average_delay_state']).type,
      delayTimeDetail: json['delay_time_detail'].map<WarehouseDelay>((x) => WarehouseDelay.fromJson(x)).toList(),
      distance: json['distance'],
    );
  }
}
