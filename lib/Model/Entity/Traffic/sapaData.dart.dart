import 'sapaInfo.dart';

class TrafficSapaData {
  final int areaId;
  final String areaName;
  final int roadId;
  final String roadName;
  final List<TrafficSapaInfo> sapaInfo;

  TrafficSapaData({
    required this.areaId,
    required this.areaName,
    required this.roadId,
    required this.roadName,
    required this.sapaInfo,
  });

  factory TrafficSapaData.fromJson(Map<String, dynamic> json) {
    return TrafficSapaData(
      areaId: json['area_id'],
      areaName: json['area_name'],
      roadId: json['road_id'],
      roadName: json['road_name'],
      sapaInfo: json['sapa_info'].map<TrafficSapaInfo>((x) => TrafficSapaInfo.fromJson(x)).toList(),
    );
  }
}
