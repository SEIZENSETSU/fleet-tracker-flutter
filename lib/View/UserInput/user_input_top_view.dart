import 'package:fleet_tracker/Model/Entity/warehouse.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class UserInputTopView extends StatefulWidget {
  const UserInputTopView({super.key});

  @override
  State<UserInputTopView> createState() => _UserInputTopViewState();
}

class _UserInputTopViewState extends State<UserInputTopView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: 'エリア内倉庫一覧',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < 10; i++)
                Container(
                  width: size.width * 0.95,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CommonCard(
                      content: UserInputCell(
                        warehouseName: 'エルフーズ東京',
                        traficstateCount: [10, 2, 34, 1, 0],
                        delayStateType: 'pause',
                        toWarehousePage: () {
                          WarehouseDetailRoute(
                            $extra: Warehouse(
                              id: 1,
                              areaId: 1,
                              name: 'エルフーズ東京',
                              latitude: 35.681236,
                              longitude: 139.767125,
                            ),
                            traficstateCount: [10, 2, 34, 1, 0],
                            delayStateType: 'pause',
                          ).push(context);
                        },
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
