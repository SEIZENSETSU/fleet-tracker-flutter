import 'package:fleet_tracker/Model/Entity/warehouse.dart';
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
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(),
    );
  }
}
