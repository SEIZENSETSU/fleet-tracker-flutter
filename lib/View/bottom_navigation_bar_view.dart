import 'package:flutter/material.dart';

import '../Controller/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarController controller =
        BottomNavigationBarController();

    return Scaffold(
      body: controller.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'ホーム'),
          NavigationDestination(icon: Icon(Icons.search), label: '倉庫検索'),
          SizedBox(width: 0),
          NavigationDestination(icon: Icon(Icons.traffic), label: '交通情報'),
          NavigationDestination(icon: Icon(Icons.settings), label: '設定'),
        ],
        onDestinationSelected: (index) {
          controller.goBranch(index);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goBranch(2);
        },
        foregroundColor: Colors.white,
        backgroundColor: controller.getFloatingActionButtonColor(2),
        child: const Icon(Icons.add),
      ),
    );
  }
}
