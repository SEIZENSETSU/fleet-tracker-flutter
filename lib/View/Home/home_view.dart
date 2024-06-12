import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../Component/CustomWidget/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FleetTracker',
        // leadingImage: Assets.images.component.anpan.provider(),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   )
        // ],
      ),
      body: Center(
          child: CustomButton(
        text: 'こんにちは',
        onTap: () {},
        primaryColor: ColorName.mianThemeColor,
        isFilledColor: true,
      )),
    );
  }
}
