import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorDialog {
  showErrorDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required String detail,
    required String buttonText,
    Function? buttonAction,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  color: ColorName.mainthemeColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        width: 200,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CustomText(
                            text: title,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Center(
                                  child: content,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      text: detail,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CustomButton(
                              primaryColor: ColorName.mainthemeColor,
                              text: buttonText,
                              onTap: buttonAction != null
                                  ? () {
                                      // 指定した処理
                                      buttonAction();
                                    }
                                  : () {
                                      // 戻る
                                      context.pop();
                                    },
                            ),
                          ),
                        ),
                      ),
                    ],
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
