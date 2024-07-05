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
      case SearchAreaImageEnum.hokkaidou:
        return Assets.images.area.hokkaido.image();
      case SearchAreaImageEnum.tohoku:
        return Assets.images.area.tohoku.image();
      case SearchAreaImageEnum.kantou:
        return Assets.images.area.kanto.image();
      case SearchAreaImageEnum.tyuubu:
        return Assets.images.area.chubu.image();
      case SearchAreaImageEnum.kinki:
        return Assets.images.area.kinki.image();
      case SearchAreaImageEnum.tyuugokuShikoku:
        return Assets.images.area.chugokuSikoku.image();
      case SearchAreaImageEnum.kyuusyuu:
        return Assets.images.area.kyushu.image();
    }
  }
}
