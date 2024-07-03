enum TrafficDetailState {
  closure,
  jam,
}

class TrafficDetailStateType {
  late TrafficDetailState type;
  TrafficDetailStateType(String rowType) {
    switch (rowType) {
      case 'closure':
        type = TrafficDetailState.closure;
        break;
      case 'jam':
        type = TrafficDetailState.jam;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  String JapaneseText() {
    switch (type) {
      case TrafficDetailState.closure:
        return '通行止・規制';
      case TrafficDetailState.jam:
        return '渋滞';
      default:
        throw Exception('Unknown type: $type');
    }
  }
}
