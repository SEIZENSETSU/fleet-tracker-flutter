import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CirclarProgressIndicatorCell extends StatelessWidget {
  const CirclarProgressIndicatorCell({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.destinationshadowColor,
      height: height,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }
}
