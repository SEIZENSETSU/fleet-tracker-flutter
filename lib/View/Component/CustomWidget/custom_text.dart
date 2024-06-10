import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: color ?? ColorName.textBlack,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontFamily: 'Noto_Sans_JP',
    );
    return Text(
      text,
      style: textStyle,
    );
  }
}
