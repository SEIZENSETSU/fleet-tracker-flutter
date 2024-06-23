class TrafficSapaInfo {
  final String name;
  final String direction;
  final String totalCongestion;
  final String smallCarCongestion;
  final String largeCarCongestion;

  TrafficSapaInfo({
    required this.name,
    required this.direction,
    required this.totalCongestion,
    required this.smallCarCongestion,
    required this.largeCarCongestion,
  });

  factory TrafficSapaInfo.fromJson(Map<String, dynamic> json) {
    return TrafficSapaInfo(
      name: json['name'],
      direction: json['direction'],
      totalCongestion: json['total_congestion'],
      smallCarCongestion: json['small_car_congestion'],
      largeCarCongestion: json['large_car_congestion'],
    );
  }
}
