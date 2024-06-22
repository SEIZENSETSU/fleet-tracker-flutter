import 'area.dart';
import 'summary.dart';

class TrafficAbout {
  final TrafficSummary summary;
  final List<TrafficArea> data;

  TrafficAbout({
    required this.summary,
    required this.data,
  });

  factory TrafficAbout.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrafficAbout(
      summary: TrafficSummary.fromJson(json['summary']),
      data: json['data'].map<TrafficArea>((x) => TrafficArea.fromJson(x)).toList(),
    );
  }
}
