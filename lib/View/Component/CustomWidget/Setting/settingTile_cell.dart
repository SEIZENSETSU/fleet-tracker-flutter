import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';

class SettingTileCell {
  Widget settingCell(
    String subTitle, {
    bool isTapped = false,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: isTapped ? onTap : null,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
        child: Row(
          children: [
            CustomText(
              text: subTitle,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingCellDetail(
      {required String title, required String detail, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14),
        child: Row(
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            const Spacer(),
            CustomText(
              text: detail,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: ColorName.textBlack,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingCellWithSwitch({
    required String subTitle,
    required void Function(bool) cellAction,
    required bool switchValue,
  }) {
    return Container(
      margin: const EdgeInsets.all(0),
      color: Colors.white,
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
      child: Row(
        children: [
          CustomText(
            text: subTitle,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: switchValue,
              onChanged: cellAction,
              activeColor: ColorName.mianThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}
