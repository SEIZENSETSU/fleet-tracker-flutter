import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/BackgroundLocator/background_locator_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Route/navigation_shell.dart';

class BottomNavigationBarController {
  BackgroundLocatorService get backgroundLocatorService =>
      BackgroundLocatorService();

  late StatefulNavigationShell navigationShell;

  BottomNavigationBarController() {
    navigationShell = NavigationShell().get();
  }

  /// アプリのライフサイクルをコントロールする
  void appLifecycleState(AppLifecycleState state) {
    Log.echo('AppLifecycleState: $state', symbol: '🔍');

    /// 本流Isolateが破棄されたときに、Observerを破棄する
    if (state == AppLifecycleState.detached) {
      backgroundLocatorService.dispose();
    }
  }

  /// 指定したインデックスのブランチに移動する
  void goBranch(int index) {
    if (index == navigationShell.currentIndex) {
      return;
    }

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
