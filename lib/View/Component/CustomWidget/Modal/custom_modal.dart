import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomModal {
  showModal({
    required BuildContext context,
    required Size size,
    required String title,
    required Widget content,
    Color? modalColor = Colors.white,
    Color? barrierColor,
    bool? expand = true,
  }) {
    showCupertinoModalBottomSheet(
      expand: expand!,
      context: context,
      isDismissible: false,
      enableDrag: false,
      barrierColor: barrierColor,
      backgroundColor: modalColor,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
        ),
      ),
      builder: (context) => StatefulBuilder(builder: (
        context,
        StateSetter setState,
      ) {
        return SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              //
              // Modalタイトルと戻るボタン表示部
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.08,
                    child: Center(
                      child: CustomText(text: title),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.08,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.height * 0.05,
                              height: size.height * 0.05,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorName.cloudColor),
                              child: const FittedBox(
                                fit: BoxFit.contain,
                                child: CustomText(
                                  text: '×',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //
              // 本体表示部
              content,
            ],
          ),
        );
      }),
    );
  }
}
