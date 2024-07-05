import 'package:fleet_tracker/Model/Data/Warehouse/search_info_data.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Controller/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BottomNavigationBarController().appLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarController controller = BottomNavigationBarController();
    return Scaffold(
      body: controller.navigationShell,
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          NavigationBar(
            selectedIndex: controller.navigationShell.currentIndex,
            indicatorColor: Colors.green.withOpacity(0.2),
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
          Positioned(
            top: -30,
            child: Consumer(builder: (context, ref, _) {
              final warehouseSearchInfo =
                  ref.watch(warehouseSearchInfoDataProvider);
              return GestureDetector(
                onTap: () {
                  if (!warehouseSearchInfo.getData().isInvading) {
                    Fluttertoast.showToast(
                      msg: 'エリアに入っていません',
                    );
                    return;
                  }
                  controller.goBranch(2);
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: warehouseSearchInfo.getData().isInvading
                        ? ColorName.mainthemeColor
                        : Colors.grey,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '投稿',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
