import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../gen/assets.gen.dart';

class CommonCell extends StatefulWidget {
  const CommonCell({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<CommonCell> createState() => _CommonCellState();
}

class _CommonCellState extends State<CommonCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: List<BoxShadow>.generate(
            3,
            (index) => BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Center(
                child: Assets.images.component.anpan.image(),
              ),
            ),
            Container(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
