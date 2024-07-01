enum FunctionTypeEnum {
  home,
  search,
  userInput,
  trafficInformation,
  setting,
}

class FunctionType {
  late FunctionTypeEnum type;
  FunctionType(String rowType) {
    switch (rowType) {
      case 'home':
        type = FunctionTypeEnum.home;
        break;
      case 'search':
        type = FunctionTypeEnum.search;
        break;
      case 'userInput':
        type = FunctionTypeEnum.userInput;
        break;
      case 'trafficInformation':
        type = FunctionTypeEnum.trafficInformation;
        break;
      case 'setting':
        type = FunctionTypeEnum.setting;
        break;
      default:
        throw Exception('Unknown type: $rowType');
    }
  }

  int branchIndex() {
    switch (type) {
      case FunctionTypeEnum.home:
        return 0;
      case FunctionTypeEnum.search:
        return 1;
      case FunctionTypeEnum.userInput:
        return 2;
      case FunctionTypeEnum.trafficInformation:
        return 3;
      case FunctionTypeEnum.setting:
        return 4;
      default:
        return 0;
    }
  }
}
