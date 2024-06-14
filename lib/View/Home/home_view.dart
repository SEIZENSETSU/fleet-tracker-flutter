import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Dialog/error_dialog.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';
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
      ),
      body: Center(
          child: CustomButton(
        text: 'こんにちは',
        onTap: () {
          ErrorDialog().showErrorDialog(
            context: context,
            title: Strings.CONNECT_ERROR_DIALOG_TITLE,
            content: Assets.images.component.anpan.image(),
            detail: Strings.CONNECT_ERROR_DIALOG_DETAIL,
          );
        },
        primaryColor: ColorName.mianThemeColor,
        isFilledColor: true,
      )),
    );
  }
}
