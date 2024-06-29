import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';

class HomeController {
  pushFunctionCard(int index) {
    BottomNavigationBarController().goBranch(index);
  }
}
