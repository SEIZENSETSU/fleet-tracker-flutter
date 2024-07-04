import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum AreaImageEnum {
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

class AreaImageType {
  late AreaImageEnum type;
  AreaImageType(int rowType) {
    switch (rowType) {
      case 1:
        type = AreaImageEnum.hokkaido;
        break;
      case 2:
        type = AreaImageEnum.tohoku;
        break;
      case 3:
        type = AreaImageEnum.kanto;
        break;
      case 4:
        type = AreaImageEnum.shinetsu;
        break;
      case 5:
        type = AreaImageEnum.tokai;
        break;
      case 6:
        type = AreaImageEnum.kinki;
        break;
      case 7:
        type = AreaImageEnum.chugoku;
        break;
      case 8:
        type = AreaImageEnum.shikoku;
        break;
      case 9:
        type = AreaImageEnum.kyushu;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  Image image() {
    switch (type) {
      case AreaImageEnum.hokkaido:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.tohoku:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.kanto:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.shinetsu:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.tokai:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.kinki:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.chugoku:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.shikoku:
        return Assets.images.icons.errorDialogIcon.image();
      case AreaImageEnum.kyushu:
        return Assets.images.icons.errorDialogIcon.image();
      default:
        throw Exception('Unknown type: $type');
    }
  }
}