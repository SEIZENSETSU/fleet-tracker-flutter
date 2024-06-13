import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.title = '',
    this.backgroundColor = ColorName.mianThemeColor,
    this.foregroundColor = Colors.white,
    this.isBackButton = false,
    this.appBarHight = kToolbarHeight,
    this.leadingImage,
    this.actions,
  }) : super(key: key);
  final String? title;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool? isBackButton;
  final ImageProvider? leadingImage;
  double? appBarHight;
  List<IconButton>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHight!); // ここでAppBarの高さを指定
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          widget.leadingImage != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: widget.appBarHight!,
                    width: widget.appBarHight!,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.leadingImage!,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          CustomText(
            text: widget.title!,
            color: widget.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      automaticallyImplyLeading: widget.isBackButton!,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      // スクロール時に色が乗算されるのを防ぐ
      surfaceTintColor: widget.backgroundColor,
      // 設置しても3つくらいまでが限度かなーー？
      actions: widget.actions != null ? widget.actions : null,
    );
  }
}
