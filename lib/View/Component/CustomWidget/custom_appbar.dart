import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    this.title = '',
    this.backgroundColor = Colors.white,
    this.foregroundColor = ColorName.textBlack,
    this.isBackButton = false,
    this.appBarHight = kToolbarHeight,
    this.leadingImage,
    this.actions,
  });
  final String? title;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool? isBackButton;
  final ImageProvider? leadingImage;
  double? appBarHight;
  List<IconButton>? actions;

  @override
  Size get preferredSize => Size.fromHeight(appBarHight!); // ここでAppBarの高さを指定

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          leadingImage != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: appBarHight!,
                    width: appBarHight!,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: leadingImage!,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          CustomText(
            text: title!,
            color: foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
      automaticallyImplyLeading: isBackButton!,
      backgroundColor: backgroundColor,

      // スクロール時に色が乗算されるのを防ぐ
      surfaceTintColor: backgroundColor,
      // 設置しても3つくらいまでが限度かなーー？
      actions: actions != null ? actions : null,
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.1),
    );
  }
}
