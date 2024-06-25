import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Controller/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView>
    with WidgetsBindingObserver {
  late BottomNavigationBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomNavigationBarController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _controller.appLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _controller.navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'ホーム'),
          NavigationDestination(icon: Icon(Icons.search), label: '倉庫検索'),
          SizedBox(width: 0),
          NavigationDestination(icon: Icon(Icons.traffic), label: '交通情報'),
          NavigationDestination(icon: Icon(Icons.settings), label: '設定'),
        ],
        onDestinationSelected: (index) {
          _controller.goBranch(index);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          final warehouseSearchInfo =
              ref.watch(warehouseSearchInfoDataProvider);
          Log.toast('isInvading: ${warehouseSearchInfo.getData().isInvading}');
          return FloatingActionButton(
            onPressed: () {
              if (!warehouseSearchInfo.getData().isInvading) {
                return;
              }
              _controller.goBranch(2);
            },
            foregroundColor: Colors.white,
            backgroundColor: _controller.getFloatingActionButtonColor(2),
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
