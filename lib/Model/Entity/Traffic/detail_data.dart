import 'issue.dart';

class TrafficDetailData {
  final int areaId;
  final String areaName;
  final int roadId;
  final String roadName;
  final List<TrafficIssue> issues;

  TrafficDetailData({
    required this.areaId,
    required this.areaName,
    required this.roadId,
    required this.roadName,
    required this.issues,
  });

  factory TrafficDetailData.fromJson(Map<String, dynamic> json) {
    return TrafficDetailData(
      areaId: json['area_id'],
      areaName: json['area_name'],
      roadId: json['road_id'],
      roadName: json['road_name'],
      issues: json['issues'].map<TrafficIssue>((x) => TrafficIssue.fromJson(x)).toList(),
    );
  }
}
