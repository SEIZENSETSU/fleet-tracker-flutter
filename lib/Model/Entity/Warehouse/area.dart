import 'warehouse.dart';

class WarehouseArea {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final List<Warehouse> warehouses;

  WarehouseArea({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.warehouses,
  });

  factory WarehouseArea.fromJson(Map<String, dynamic> json) {
    return WarehouseArea(
      id: json['warehouse_area_id'],
      name: json['warehouse_area_name'],
      latitude: json['warehouse_area_latitude'],
      longitude: json['warehouse_area_longitude'],
      warehouses: json['warehouses'].map<Warehouse>((x) => Warehouse.fromJson(x)).toList(),
    );
  }
}
