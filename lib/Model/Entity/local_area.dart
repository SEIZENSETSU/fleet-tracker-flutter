import 'Warehouse/area.dart';

class LocalArea {
  final int id;
  final String name;
  final List<WarehouseArea> warehouseAreas;

  LocalArea({
    required this.id,
    required this.name,
    required this.warehouseAreas,
  });

  factory LocalArea.fromJson(Map<String, dynamic> json) {
    return LocalArea(
      id: json['local_area_id'],
      name: json['local_area_name'],
      warehouseAreas: json['warehouse_areas'].map<WarehouseArea>((x) => WarehouseArea.fromJson(x)).toList(),
    );
  }
}
