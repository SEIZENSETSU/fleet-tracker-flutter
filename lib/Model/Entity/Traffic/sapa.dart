import 'package:fleet_tracker/Model/Entity/Traffic/sapa_data.dart';

import 'summary.dart';

class TrafficSapa {
  final TrafficSummary summary;
  final TrafficSapaData data;

  TrafficSapa({
    required this.summary,
    required this.data,
  });

  factory TrafficSapa.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrafficSapa(
      summary: TrafficSummary.fromJson(json['summary']),
      data: TrafficSapaData.fromJson(json['data']),
    );
  }
}
