import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
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
        return Image.asset(Assets.images.icons.sunIcon.path);
      case WeatherStateEnum.cloud:
        return Image.asset(
          Assets.images.icons.cloudIcon.path,
          color: Colors.grey,
        );
      case WeatherStateEnum.rain:
        return Image.asset(Assets.images.icons.rainIcon.path);

      default:
        return Image.asset(Assets.images.icons.sunIcon.path);
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
        return ColorName.sunColor;
      case WeatherStateEnum.cloud:
        return ColorName.cloudColor;
      case WeatherStateEnum.rain:
        return ColorName.rainColor;
      default:
        return Colors.amber;
    }
  }
}
