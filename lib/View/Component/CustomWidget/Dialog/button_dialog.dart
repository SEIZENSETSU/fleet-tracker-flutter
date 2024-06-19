import 'package:fleet_tracker/Constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../custom_button.dart';
import '../custom_text.dart';

class ButtonDialog {
  showButtonDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required String detail,
    bool barrierDismissible = false,
    String rightButtonText = Strings.SUBMIT_BUTTON_TEXT,
    String leftButtonText = Strings.BACK_BUTTON_TEXT,
    required Function rightButtonAction,
    Function? leftButtonAction,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      // barrierDismissible: barrierDismissible,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 150,
            // height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: ColorName.mainthemeColor,
                  spreadRadius: 1.0,
                  blurRadius: 0,
                  offset: Offset(5, 5),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  color: ColorName.mainthemeColor.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 30,
                        width: 200,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CustomText(
                            text: title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Center(
                              child: content,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                children: [
                                  CustomText(
                                    text: detail,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                child: CustomButton(
                                  primaryColor: ColorName.mainthemeColor,
                                  text: leftButtonText,
                                  onTap: leftButtonAction != null
                                      ? () {
                                          leftButtonAction();
                                        }
                                      : () {
                                          // nullなら戻る
                                          context.pop();
                                        },
                                ),
                              ),
                              Container(
                                width: 100,
                                child: CustomButton(
                                  isFilledColor: true,
                                  primaryColor: ColorName.mainthemeColor,
                                  text: rightButtonText,
                                  onTap: rightButtonAction,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
