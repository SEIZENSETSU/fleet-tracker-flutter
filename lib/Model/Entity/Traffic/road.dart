class TrafficRoad {
  final int id;
  final String name;
  final bool provideSapa;
  final int closure;
  final int jam;

  TrafficRoad({
    required this.id,
    required this.name,
    required this.provideSapa,
    required this.closure,
    required this.jam,
  });

  factory TrafficRoad.fromJson(Map<String, dynamic> json) {
    return TrafficRoad(
      id: json['road_id'],
      name: json['road_name'],
      provideSapa: json['provide_sapa'],
      closure: json['closure'],
      jam: json['jam'],
    );
  }
}
