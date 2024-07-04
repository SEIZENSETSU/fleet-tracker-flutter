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
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.tohoku:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.kanto:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.shinetsu:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.tokai:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.kinki:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.chugoku:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.shikoku:
        return Assets.images.icons.errorDialogIcon.image();
      case TrafficAreaImageEnum.kyushu:
        return Assets.images.icons.errorDialogIcon.image();
      default:
        throw Exception('Unknown type: $type');
    }
  }
}
