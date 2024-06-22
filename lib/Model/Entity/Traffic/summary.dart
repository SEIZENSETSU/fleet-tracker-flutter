class TrafficSummary {
  final DateTime timestamp;
  final DateTime updateTimestamp;

  TrafficSummary({
    required this.timestamp,
    required this.updateTimestamp,
  });

  factory TrafficSummary.fromJson(Map<String, dynamic> json) {
    return TrafficSummary(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      updateTimestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
    );
  }
}
