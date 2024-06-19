import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class UserInputCircleCell extends StatelessWidget {
  const UserInputCircleCell({
    super.key,
    required this.cellColor,
    required this.text,
    required this.onTap,
  });

  final Color cellColor;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: cellColor, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: const Offset(0, 2),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.lerp(
                cellColor,
                Colors.white,
                0.5,
              ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: CustomText(
                  text: text,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
