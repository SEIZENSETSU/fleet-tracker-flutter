import 'area.dart';
import 'summary.dart';

class TrafficAbout {
  final TrafficSummary summary;
  final List<TrafficArea> dataList;

  TrafficAbout({
    required this.summary,
    required this.dataList,
  });

  factory TrafficAbout.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrafficAbout(
      summary: TrafficSummary.fromJson(json['summary']),
      dataList: json['data'].map<TrafficArea>((x) => TrafficArea.fromJson(x)).toList(),
    );
  }
}
