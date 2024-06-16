import 'package:flutter/material.dart';

class DestinationArrow extends StatefulWidget {
  const DestinationArrow({super.key});

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
    );
  }
}
