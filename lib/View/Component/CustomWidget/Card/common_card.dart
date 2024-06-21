import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../gen/colors.gen.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.content,
    this.cardColor = Colors.white,
  });
  // シンプルな影付きのカード
  // 高さ・横幅は親で指定してあげよう
  final Widget content;
  final Color? cardColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: content,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: cardColor,
        boxShadow: const [
          BoxShadow(
            color: ColorName.destinationshadowColor,
            spreadRadius: 1.0,
            blurRadius: 5,
          )
        ],
      ),
    );
  }
}
