class Warehouse {
  final int id;
  final int areaId;
  final String name;
  final double latitude;
  final double longitude;

  Warehouse({
    required this.id,
    required this.areaId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['warehouse_id'],
      areaId: json['warehouse_area_id'],
      name: json['warehouse_name'],
      latitude: json['warehouse_latitude'],
      longitude: json['warehouse_longitude'],
    );
  }

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      id: map['warehouse_id'],
      areaId: map['warehouse_area_id'],
      name: map['warehouse_name'],
      latitude: map['warehouse_latitude'],
      longitude: map['warehouse_longitude'],
    );
  }
}
