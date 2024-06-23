import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum WeatherStateEnum {
  sun,
  cloud,
  rain,
}

class WeatherStateType {
  late WeatherStateEnum type;
  WeatherStateType(String rowType) {
    switch (rowType) {
      case 'sun':
        type = WeatherStateEnum.sun;
        break;
      case 'cloud':
        type = WeatherStateEnum.cloud;
        break;
      case 'rain':
        type = WeatherStateEnum.rain;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  Image image() {
    switch (type) {
      case WeatherStateEnum.sun:
        return Image.asset(Assets.images.icon.sunIcon.path);
      case WeatherStateEnum.cloud:
        return Image.asset(
          Assets.images.icon.cloudIcon.path,
          color: Colors.grey,
        );
      case WeatherStateEnum.rain:
        return Image.asset(Assets.images.icon.rainIcon.path);

      default:
        return Image.asset(Assets.images.icon.sunIcon.path);
    }
  }

  String title() {
    switch (type) {
      case WeatherStateEnum.sun:
        return '晴れ';
      case WeatherStateEnum.cloud:
        return 'くもり';
      case WeatherStateEnum.rain:
        return '雨';
      default:
        return '';
    }
  }

  Color color() {
    switch (type) {
      case WeatherStateEnum.sun:
        return const Color.fromARGB(255, 255, 213, 87);
      case WeatherStateEnum.cloud:
        return Color.fromARGB(255, 190, 190, 190);
      case WeatherStateEnum.rain:
        return const Color.fromARGB(255, 109, 186, 248);
      default:
        return Colors.amber;
    }
  }
}
