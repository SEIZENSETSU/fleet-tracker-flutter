import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum TrafficAreaImageEnum {
  hokkaido,
  tohoku,
  kanto,
  shinetsu,
  tokai,
  kinki,
  chugoku,
  shikoku,
  kyushu,
}

class TrafficAreaImageType {
  late TrafficAreaImageEnum type;
  TrafficAreaImageType(int rowType) {
    switch (rowType) {
      case 1:
        type = TrafficAreaImageEnum.hokkaido;
        break;
      case 2:
        type = TrafficAreaImageEnum.tohoku;
        break;
      case 3:
        type = TrafficAreaImageEnum.kanto;
        break;
      case 4:
        type = TrafficAreaImageEnum.shinetsu;
        break;
      case 5:
        type = TrafficAreaImageEnum.tokai;
        break;
      case 6:
        type = TrafficAreaImageEnum.kinki;
        break;
      case 7:
        type = TrafficAreaImageEnum.chugoku;
        break;
      case 8:
        type = TrafficAreaImageEnum.shikoku;
        break;
      case 9:
        type = TrafficAreaImageEnum.kyushu;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  Image image() {
    switch (type) {
      case TrafficAreaImageEnum.hokkaido:
        return Assets.images.area.hokkaido.image();
      case TrafficAreaImageEnum.tohoku:
        return Assets.images.area.tohoku.image();
      case TrafficAreaImageEnum.kanto:
        return Assets.images.area.kanto.image();
      case TrafficAreaImageEnum.shinetsu:
        return Assets.images.area.shinetsu.image();
      case TrafficAreaImageEnum.tokai:
        return Assets.images.area.tokai.image();
      case TrafficAreaImageEnum.kinki:
        return Assets.images.area.kinki.image();
      case TrafficAreaImageEnum.chugoku:
        return Assets.images.area.chugoku.image();
      case TrafficAreaImageEnum.shikoku:
        return Assets.images.area.shikoku.image();
      case TrafficAreaImageEnum.kyushu:
        return Assets.images.area.kyushu.image();
      default:
        throw Exception('Unknown type: $type');
    }
  }
}
