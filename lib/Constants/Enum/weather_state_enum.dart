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
}
