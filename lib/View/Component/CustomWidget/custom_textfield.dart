import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.backgroundcolor,
    required this.controller,
  });

  final String hintText;
  final Color backgroundcolor;
  final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // フォーカス関連は時間かかるのでスキップ
      // autofocus: true,
      controller: widget.controller,
      onChanged: (value) {
        //一旦、あとでstlに戻す
        setState(() {});
      },
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        decoration: TextDecoration.underline,
        decorationColor: ColorName.mainthemeColor,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
          color: ColorName.mainthemeColor,
        ),
        suffixIcon: Visibility(
          visible: widget.controller.text.length != 0,
          child: IconButton(
            icon: Icon(
              Icons.cancel_rounded,
              color: Colors.grey,
            ),
            onPressed: () {
              widget.controller.text = '';
              setState(() {});
            },
          ),
        ),
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          decoration: TextDecoration.none,
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Noto_Sans_JP',
        ),
        filled: true,
        fillColor: widget.backgroundcolor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
      ),
      cursorColor: ColorName.mainthemeColor,
      cursorWidth: 2,
      cursorRadius: const Radius.circular(10),
    );
  }
}
