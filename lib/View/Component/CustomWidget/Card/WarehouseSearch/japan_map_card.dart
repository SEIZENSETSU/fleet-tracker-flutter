import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JapanMapCard extends StatelessWidget {
  const JapanMapCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorName.mainthemeColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: CustomText(
          text: name,
          color: Colors.white,
        ),
      ),
    );
  }
}
