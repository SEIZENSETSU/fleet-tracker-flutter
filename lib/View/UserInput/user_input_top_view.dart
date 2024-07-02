import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/Data/Warehouse/search_info_data.dart';

class UserInputTopView extends StatefulWidget {
  const UserInputTopView({super.key});

  @override
  State<UserInputTopView> createState() => _UserInputTopViewState();
}

class _UserInputTopViewState extends State<UserInputTopView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer(builder: (context, ref, _) {
      final warehouseSearchInfo = ref.watch(warehouseSearchInfoDataProvider);
      final _data = warehouseSearchInfo.getData();
      return Scaffold(
        backgroundColor: ColorName.scaffoldBackground,
        appBar: CustomAppBar(
          title: 'エリア内倉庫一覧',
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (final data in _data.warehouses!)
                  Container(
                    width: size.width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CommonCard(
                        content: UserInputCell(
                          warehouseId: data.warehouseId,
                          warehouseName: data.warehouseName,
                          traficstateCountList: data.delayTimeDetails,
                          delayStateType: data.averageDelayState.name,
                          toWarehousePage: () {
                            WarehouseDetailRoute(
                              $extra: data,
                              functionType: 'userInput',
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
    });
  }
}
