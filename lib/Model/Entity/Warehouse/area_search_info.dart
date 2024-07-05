import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';
import 'package:flutter/cupertino.dart';

class WarehouseAreaSearchInfo {
  final int warehouseAreaId;
  final String warehouseAreaName;
  final WarehouseDelayState averageDelayState;
  final double distance;
  final double latitude;
  final double longitude;

  WarehouseAreaSearchInfo({
    required this.warehouseAreaId,
    required this.warehouseAreaName,
    required this.averageDelayState,
    required this.distance,
    required this.latitude,
    required this.longitude,
  });

  factory WarehouseAreaSearchInfo.fromJson(Map<String, dynamic> json) {
    return WarehouseAreaSearchInfo(
        warehouseAreaId: json['warehouse_area_id'],
        warehouseAreaName: json['warehouse_area_name'],
        averageDelayState:
            WarehouseDelayStateType(json['average_delay_state']).type,
        distance: double.parse(json['distance'].toString()),
        latitude: json['warehouse_area_latitude'],
        longitude: json['warehouse_area_longitude']);
  }

  Map<String, dynamic> toJson() {
    return {
      'warehouse_area_id': warehouseAreaId,
      'warehouse_area_name': warehouseAreaName,
      'average_delay_state': averageDelayState.name,
      'distance': distance,
      'warehouse_area_latitude': latitude,
      'warehouse_area_longitude': longitude
    };
  }
}
