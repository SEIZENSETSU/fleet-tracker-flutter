import 'package:fleet_tracker/Model/Entity/Traffic/detail_data.dart';

import 'summary.dart';

class TrafficDetail {
  final TrafficSummary summary;
  final TrafficDetailData data;

  TrafficDetail({
    required this.summary,
    required this.data,
  });

  factory TrafficDetail.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrafficDetail(
      summary: TrafficSummary.fromJson(json['summary']),
      data: TrafficDetailData.fromJson(json['data']),
    );
  }
}
