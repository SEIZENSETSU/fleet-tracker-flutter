import 'sapa_info.dart';

class TrafficSapaData {
  final int areaId;
  final String areaName;
  final int roadId;
  final String roadName;
  final List<TrafficSapaInfo> sapaInfoList;

  TrafficSapaData({
    required this.areaId,
    required this.areaName,
    required this.roadId,
    required this.roadName,
    required this.sapaInfoList,
  });

  factory TrafficSapaData.fromJson(Map<String, dynamic> json) {
    return TrafficSapaData(
      areaId: json['area_id'],
      areaName: json['area_name'],
      roadId: json['road_id'],
      roadName: json['road_name'],
      sapaInfoList: json['sapa_info'].map<TrafficSapaInfo>((x) => TrafficSapaInfo.fromJson(x)).toList(),
    );
  }
}
