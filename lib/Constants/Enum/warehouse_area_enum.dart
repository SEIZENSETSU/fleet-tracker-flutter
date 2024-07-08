enum WarehouseAreaEnum {
  hokkaido,
  touhoku,
  saitama,
  tokyo,
  chiba,
  kanagawa,
  chubu,
  kinki,
  chugoku,
  shikoku,
  kyushu,
  okinawa,
}

class WarehouseAreaType {
  late WarehouseAreaEnum type;
  WarehouseAreaType(int rowType) {
    switch (rowType) {
      case 1:
        type = WarehouseAreaEnum.hokkaido;
        break;
      case 2:
        type = WarehouseAreaEnum.touhoku;
        break;
      case 3:
        type = WarehouseAreaEnum.chubu;
        break;
      case 4:
        type = WarehouseAreaEnum.kinki;
        break;
      case 5:
        type = WarehouseAreaEnum.chugoku;
        break;
      case 6:
        type = WarehouseAreaEnum.shikoku;
        break;
      case 7:
        type = WarehouseAreaEnum.kyushu;
        break;
      case 8:
        type = WarehouseAreaEnum.okinawa;
        break;
      case 9:
        type = WarehouseAreaEnum.kanagawa;
        break;
      case 10:
        type = WarehouseAreaEnum.chiba;
        break;
      case 11:
        type = WarehouseAreaEnum.tokyo;
        break;
      case 12:
        type = WarehouseAreaEnum.saitama;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  String name() {
    switch (type) {
      case WarehouseAreaEnum.hokkaido:
        return '北海道エリア';
      case WarehouseAreaEnum.touhoku:
        return '東北エリア';
      case WarehouseAreaEnum.saitama:
        return '埼玉エリア';
      case WarehouseAreaEnum.tokyo:
        return '東京エリア';
      case WarehouseAreaEnum.chiba:
        return '千葉エリア';
      case WarehouseAreaEnum.kanagawa:
        return '神奈川エリア';
      case WarehouseAreaEnum.chubu:
        return '中部エリア';
      case WarehouseAreaEnum.kinki:
        return '近畿エリア';
      case WarehouseAreaEnum.chugoku:
        return '中国エリア';
      case WarehouseAreaEnum.shikoku:
        return '四国エリア';
      case WarehouseAreaEnum.kyushu:
        return '九州エリア';
      case WarehouseAreaEnum.okinawa:
        return '沖縄エリア';
      default:
        return '';
    }
  }
}
