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
}
