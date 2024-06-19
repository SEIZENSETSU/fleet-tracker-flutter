import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import '../../Constants/const.dart';
import '../Component/CustomWidget/custom_text.dart';

class UserInputTopView extends StatefulWidget {
  const UserInputTopView({super.key});

  @override
  State<UserInputTopView> createState() => _UserInputTopViewState();
}

class _UserInputTopViewState extends State<UserInputTopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 10,
              ),
              child: CustomText(
                text: '遅延状況',
                fontSize: 20,
              ),
            ),
            for (int i = 0; i < factoryMap.length; i++)
              Container(
                width: double.infinity,
                child: UserInputCell(
                  warehouseName: factoryMap.keys.elementAt(i),
                  traficstateCount: factoryMap[factoryMap.keys.elementAt(i)]![
                      'traficstateCount'],
                  type: factoryMap[factoryMap.keys.elementAt(i)]![
                      'delayStateType'],
                ),
              )
          ],
        ),
      ),
    );
  }
}
