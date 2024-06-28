import 'package:flutter/material.dart';

class SpacerAndDivider extends StatelessWidget {
  const SpacerAndDivider({
    super.key,
    required this.topHeight,
    required this.bottomHeight,
  });

  final double topHeight;
  final double bottomHeight;

  //
  // 上下に高さをつけてDividerを挿入するコンポーネント

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: topHeight,
        ),
        const Divider(),
        SizedBox(
          height: bottomHeight,
        ),
      ],
    );
  }
}