import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum SearchAreaImageEnum {
  hokkaidou,
  tohoku,
  kantou,
  tyuubu,
  kinki,
  tyuugokuShikoku,
  kyuusyuu,
}

class SearchAreaImageType {
  late SearchAreaImageEnum type;
  SearchAreaImageType(String rowType) {
    switch (rowType) {
      case 'hokkaidou':
        type = SearchAreaImageEnum.hokkaidou;
      case 'tohoku':
        type = SearchAreaImageEnum.tohoku;
      case 'kantou':
        type = SearchAreaImageEnum.kantou;
      case 'tyuubu':
        type = SearchAreaImageEnum.tyuubu;
      case 'kinki':
        type = SearchAreaImageEnum.kinki;
      case 'tyuugokuShikoku':
        type = SearchAreaImageEnum.tyuugokuShikoku;
      case 'kyuusyuu':
        type = SearchAreaImageEnum.kyuusyuu;
      default:
        type = SearchAreaImageEnum.hokkaidou;
    }
  }

  Image image() {
    switch (type) {
      // 飯田くんからもらった画像を後から置き換える
      case SearchAreaImageEnum.hokkaidou:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.tohoku:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.kantou:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.tyuubu:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.kinki:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.tyuugokuShikoku:
        return Assets.images.icons.cloudIcon.image();
      case SearchAreaImageEnum.kyuusyuu:
        return Assets.images.icons.cloudIcon.image();
    }
  }
}
