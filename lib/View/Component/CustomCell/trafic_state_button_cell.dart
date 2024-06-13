import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class TraficStateButtonCell extends StatefulWidget {
  const TraficStateButtonCell({
    super.key,
    required this.cellColor,
    required this.text,
    required this.onTap,
  });

  final Color cellColor;
  final String text;
  final Function onTap;
  @override
  State<TraficStateButtonCell> createState() => _TraficStateButtonCellState();
}

class _TraficStateButtonCellState extends State<TraficStateButtonCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.cellColor,
            boxShadow: [
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
                widget.cellColor,
                Colors.white,
                0.5,
              ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: CustomText(
                  text: widget.text,
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
