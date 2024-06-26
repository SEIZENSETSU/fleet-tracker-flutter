import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../gen/colors.gen.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.content,
    this.cardColor = Colors.white,
    this.onTap,
  });
  // シンプルな影付きのカード
  // 高さ・横幅は親で指定してあげよう
  final Widget content;
  final Color? cardColor;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              // 引数で渡されたら設定
              onTap!();
            }
          : null,
      child: Container(
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
      ),
    );
  }
}
