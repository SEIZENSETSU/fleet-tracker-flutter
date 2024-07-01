import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';

class WarehouseDetailController {
  bool enableAction = false;
  outArea() {
    BottomNavigationBarController().goBranch(0);
  }

  initialize(String type) {
    FunctionTypeEnum typeEnum = FunctionType(type).type;
    switch (typeEnum) {
      case FunctionTypeEnum.home:
      case FunctionTypeEnum.userInput:
        enableAction = true;
      case FunctionTypeEnum.search:
        enableAction = false;
      default:
        enableAction = false;
    }
  }
}
