import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Constants/const.dart';
import '../../Controller/bottom_navigation_bar_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BottomNavigationBarController bottomNavigationBarController =
      BottomNavigationBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        leadingImage: Assets.images.trackColor.provider(),
        title: 'FleetTracker',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '基本機能',
                fontSize: 20,
              ),
            ),
            Container(
              height: 150,
              child: Expanded(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(4.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          bottomNavigationBarController.goBranch(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: ColorName.destinationshadowColor,
                                spreadRadius: 1.0,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: ColorName.mainthemeColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: '登録',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          bottomNavigationBarController.goBranch(3);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: ColorName.destinationshadowColor,
                                spreadRadius: 1.0,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  color: ColorName.mainthemeColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: '交通情報',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '各工場の情報',
                fontSize: 20,
              ),
            ),
            for (int i = 0; i < factoryMap.length; i++)
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: DestinationCard(
                      title: factoryMap.keys.elementAt(i),
                      delayStateType: factoryMap[factoryMap.keys.elementAt(i)]![
                          'delayStateType'],
                      angle: factoryMap[factoryMap.keys.elementAt(i)]!['angle'],
                      distance:
                          factoryMap[factoryMap.keys.elementAt(i)]!['distance'],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
