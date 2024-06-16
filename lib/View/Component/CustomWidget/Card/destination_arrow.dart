import 'dart:math';

import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class DestinationArrow extends StatefulWidget {
  DestinationArrow({
    super.key,
    required this.angle,
  });

  int angle;

  @override
  State<DestinationArrow> createState() => _DestinationArrowState();
}

class _DestinationArrowState extends State<DestinationArrow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        shape: BoxShape.circle,
      ),
      // 今のところは角度を入れてもらって動的に動くようにしている。
      // 12時を0度と考えて時計回りで角度をつける。
      child: Transform.rotate(
        angle: widget.angle * pi / 180,
        child: Container(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.all(200.0),
              child: Assets.images.component.destinationArrowIcon.image(),
            ),
          ),
        ),
      ),
    );
  }
}