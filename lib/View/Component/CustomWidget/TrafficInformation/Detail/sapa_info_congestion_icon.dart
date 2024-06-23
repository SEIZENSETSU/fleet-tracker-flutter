import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class SapaInfoCongestionIcon extends StatelessWidget {
  const SapaInfoCongestionIcon(
      {super.key, required this.congestion, required this.iconColor});
  final String congestion;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Align(
        alignment: Alignment.center,
        child: CustomText(
          text: congestion,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
