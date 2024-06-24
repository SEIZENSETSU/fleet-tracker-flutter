import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';
import 'package:fleet_tracker/Model/Entity/delay_time_detail.dart';

class WarehouseState {
  final int warehouseId;
  final int warehouseAreaId;
  final String warehouseName;
  final WarehouseDelayState averageDelayState;
  final List<DelayTimeDetail> delayTimeDetails;
  final int distance;

  WarehouseState({
    required this.warehouseId,
    required this.warehouseAreaId,
    required this.warehouseName,
    required this.averageDelayState,
    required this.delayTimeDetails,
    required this.distance,
  });

  factory WarehouseState.fromJson(Map<String, dynamic> json) {
    return WarehouseState(
      warehouseId: json['warehouse_id'],
      warehouseAreaId: json['warehouse_area_id'],
      warehouseName: json['warehouse_name'],
      averageDelayState: WarehouseDelayStateType(json['average_delay_state']).type,
      delayTimeDetails: json['delay_time_detail'].map<DelayTimeDetail>((x) => DelayTimeDetail.fromJson(x)).toList(),
      distance: json['distance'],
    );
  }
}
