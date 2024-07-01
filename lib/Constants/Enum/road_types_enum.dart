enum RoadTypeEnum {
  motorway,
  trunk,
  primary,
  secondary,
}

class RoadTypeEnumType {
  late RoadTypeEnum type;
  RoadTypeEnumType(String rowType) {
    switch (rowType) {
      case 'motorway':
        type = RoadTypeEnum.motorway;
        break;
      case 'trunk':
        type = RoadTypeEnum.trunk;
        break;
      case 'primary':
        type = RoadTypeEnum.primary;
        break;
      case 'secondary':
        type = RoadTypeEnum.secondary;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }
}
