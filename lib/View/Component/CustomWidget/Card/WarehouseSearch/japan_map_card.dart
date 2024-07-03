import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JapanMapCard extends StatelessWidget {
  const JapanMapCard({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // リザルトページにいく
        WarehouseSearchResultRoute(areaId: [0], areaName: name).push(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.mainthemeColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ColorName.japanMapCardBorder,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0,
              offset: Offset(3, 3),
            )
          ],
        ),
        child: Center(
          child: CustomText(
            text: name,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
