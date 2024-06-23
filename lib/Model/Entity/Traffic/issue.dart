import 'package:fleet_tracker/Constants/Enum/traffic_detail_state_enum.dart';

class TrafficIssue {
  final TrafficDetailState type;
  final String direction;
  final String place;
  final String? content;
  final String? reason;
  final String? range;

  TrafficIssue({
    required this.type,
    required this.direction,
    required this.place,
    this.content,
    this.reason,
    this.range,
  });

  factory TrafficIssue.fromJson(Map<String, dynamic> json) {
    return TrafficIssue(
      type: TrafficDetailStateType(json['type']).type,
      direction: json['direction'],
      place: json['place'],
      content: json['content'],
      reason: json['reason'],
      range: json['range'],
    );
  }
}
