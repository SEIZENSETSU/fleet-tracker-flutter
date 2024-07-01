import 'package:fleet_tracker/Model/Entity/Weather/weather.dart';

class WeatherList {
  final Weather now;
  final Weather afterOneHour;

  WeatherList({
    required this.now,
    required this.afterOneHour,
  });

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      now: Weather.nowDataFromJson(json),
      afterOneHour: Weather.afterOneHourDataFromJson(json),
    );
  }
}
