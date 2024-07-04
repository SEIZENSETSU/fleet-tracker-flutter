import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.backgroundcolor,
    required this.controller,
    required this.isSerchIcon,
  });

  final String hintText;
  final Color backgroundcolor;
  final TextEditingController controller;
  final bool isSerchIcon;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {});
      },
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        decorationColor: ColorName.mainthemeColor,
      ),
      decoration: InputDecoration(
        prefixIcon: widget.isSerchIcon
            ? const Icon(
                Icons.search,
                size: 25,
                color: ColorName.mainthemeColor,
              )
            : null,
        suffixIcon: Visibility(
          visible: widget.controller.text.isNotEmpty,
          child: IconButton(
            icon: const Icon(
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
