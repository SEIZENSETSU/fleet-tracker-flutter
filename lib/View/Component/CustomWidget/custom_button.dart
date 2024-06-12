import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.isFilledColor = false,
    this.primaryColor = Colors.white,
    required this.text,
    required this.onTap,
  });

  final Color primaryColor;
  final bool isFilledColor;
  final String text;
  final Function onTap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onTap();
        // context.go('/bottom_tab_view');
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: widget.primaryColor,
        ),
        elevation: 0,
        fixedSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        ///isFilledColorがtrueの場合はprimaryColorを使う,falseの場合はdefaultの白
        backgroundColor:
            widget.isFilledColor ? widget.primaryColor : Colors.white,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CustomText(
          text: widget.text,
          fontSize: 14,
          color: widget.isFilledColor ? Colors.white : widget.primaryColor,
        ),
      ),
    );
  }
}
