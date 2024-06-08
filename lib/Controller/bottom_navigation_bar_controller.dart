import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Route/navigation_shell.dart';

class BottomNavigationBarController {
  late StatefulNavigationShell navigationShell;

  BottomNavigationBarController() {
    navigationShell = NavigationShell().get();
  }

  /// 指定したインデックスのブランチに移動する
  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  /// フローティングアクションボタンの色を取得する
  Color getFloatingActionButtonColor(int index) {
    return index == navigationShell.currentIndex
        ? Colors.blue
        : Colors.blueGrey;
  }
}
