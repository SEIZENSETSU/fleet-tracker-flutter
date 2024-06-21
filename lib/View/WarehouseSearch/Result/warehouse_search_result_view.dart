import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class WarehouseSearchResultView extends StatefulWidget {
  const WarehouseSearchResultView({
    super.key,
    this.are = '',
    this.areaId = 0,
  });

  final String? are;
  final int? areaId;

  @override
  State<WarehouseSearchResultView> createState() =>
      _WarehouseSearchResultViewState();
}

class _WarehouseSearchResultViewState extends State<WarehouseSearchResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: '検索結果',
        isBackButton: true,
      ),
      body: Center(
        child: CustomText(text: widget.are!),
      ),
    );
  }
}
