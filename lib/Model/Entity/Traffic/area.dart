import 'package:fleet_tracker/Model/Entity/Traffic/traffic_road_information.dart';

class TrafficArea {
  final int id;
  final String name;
  final int totalIssues;
  final List<TrafficRoad> roads;

  TrafficArea({
    required this.id,
    required this.name,
    required this.totalIssues,
    required this.roads,
  });

  factory TrafficArea.fromJson(Map<String, dynamic> json) {
    return TrafficArea(
      id: json['area_id'],
      name: json['area_name'],
      totalIssues: json['total_issues'],
      roads: json['roads'].map<TrafficRoad>((x) => TrafficRoad.fromJson(x)).toList(),
    );
  }
}
