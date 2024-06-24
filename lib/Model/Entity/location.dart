class Location {
  final double lat;
  final double lng;
  final DateTime time;

  Location({
    required this.lat,
    required this.lng,
    required this.time,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'time': time.toIso8601String(),
    };
  }
}
