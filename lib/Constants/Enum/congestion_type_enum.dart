import 'package:flutter/material.dart';

enum CongestionTypeEnum {
  empty,
  crowd,
  full,
}

class CongestionType {
  late CongestionTypeEnum type;
  CongestionType(String rowType) {
    switch (rowType) {
      case '空':
        type = CongestionTypeEnum.empty;
        break;
      case '混':
        type = CongestionTypeEnum.crowd;
        break;
      case '満':
        type = CongestionTypeEnum.full;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  Color color() {
    switch (type) {
      case CongestionTypeEnum.empty:
        return Colors.green;
      case CongestionTypeEnum.crowd:
        return Colors.orange;
      case CongestionTypeEnum.full:
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
