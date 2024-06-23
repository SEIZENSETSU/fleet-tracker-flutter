import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum WeatherState {
  sun,
  cloud,
  rain,
}

class WeatherStateType {
  late WeatherState type;
  WeatherStateType(String rowType) {
    switch (rowType) {
      case 'sun':
        type = WeatherState.sun;
        break;
      case 'cloud':
        type = WeatherState.cloud;
        break;
      case 'rain':
        type = WeatherState.rain;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  Image image() {
    switch (type) {
      case WeatherState.sun:
        return Image.asset(Assets.images.component.sunIcon.path);
      case WeatherState.cloud:
        return Image.asset(Assets.images.component.cloudIcon.path);
      case WeatherState.rain:
        return Image.asset(Assets.images.component.rainIcon.path);

      default:
        return Image.asset(Assets.images.component.sunIcon.path);
    }
  }

  String title() {
    switch (type) {
      case WeatherState.sun:
        return '晴れ';
      case WeatherState.cloud:
        return 'くもり';
      case WeatherState.rain:
        return '雨';
      default:
        return '';
    }
  }

  Color color() {
    switch (type) {
      case WeatherState.sun:
        return const Color.fromARGB(255, 255, 213, 87);
      case WeatherState.cloud:
        return Colors.grey;
      case WeatherState.rain:
        return const Color.fromARGB(255, 109, 186, 248);
      default:
        return Colors.amber;
    }
  }
}
