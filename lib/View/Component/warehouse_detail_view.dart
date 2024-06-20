import 'package:fleet_tracker/Model/Entity/warehouse.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class WarehouseDetailView extends StatefulWidget {
  const WarehouseDetailView({
    super.key,
    required this.warehouse,
    required this.traficstateCount,
    required this.delayStateType,
  });
  final Warehouse warehouse;
  final List traficstateCount;
  final String delayStateType;
  @override
  State<WarehouseDetailView> createState() => _WarehouseDetailViewState();
}

class _WarehouseDetailViewState extends State<WarehouseDetailView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: size.width * 0.95,
              // height: size.height * 0.4,
              child: CommonCard(
                content: UserInputCell(
                  warehouseName: widget.warehouse.name,
                  traficstateCount: widget.traficstateCount,
                  delayStateType: widget.delayStateType,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
