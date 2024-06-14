import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../gen/assets.gen.dart';

class ErrorDialog {
  showErrorDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required String detail,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 100,
            // height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: ColorName.mianThemeColor,
                  spreadRadius: 1.0,
                  blurRadius: 0,
                  offset: Offset(15, 15),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50,
                  color: ColorName.mianThemeColor.withOpacity(0.1),
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
                  height: 150,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Center(
                              child: content,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
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
