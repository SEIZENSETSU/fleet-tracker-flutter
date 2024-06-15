import 'package:fleet_tracker/View/Component/CustomCell/trafic_state_button_cell.dart';
import 'package:fleet_tracker/View/Component/CustomCell/trafic_state_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:flutter/material.dart';

class UserInputTopView extends StatefulWidget {
  UserInputTopView({super.key});

  @override
  State<UserInputTopView> createState() => _UserInputTopViewState();
}

class _UserInputTopViewState extends State<UserInputTopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 400,
              child: TraficStateCell(
                warehouseName: 'エルフーズ東京工場',
                traficstateCount: [0, 10, 10, 10, 0],
              ),
            ),
            TraficStateCell(
              warehouseName: 'エルフーズ東京工場',
              traficstateCount: [0, 10, 10, 10, 0],
            ),
            TraficStateCell(
              warehouseName: 'エルフーズ東京工場',
              traficstateCount: [0, 10, 10, 10, 0],
            ),
            TraficStateCell(
              warehouseName: 'エルフーズ東京工場',
              traficstateCount: [0, 10, 10, 10, 0],
            ),
            TraficStateCell(
              warehouseName: 'エルフーズ東京工場',
              traficstateCount: [0, 10, 10, 10, 0],
            ),
          ],
        ),
      ),
    );
  }
}
