import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Service/Log/log_service.dart';

class CustomDialog {
  showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    required String detail,
    String buttonText = '閉じる',
    String rejectButtonText = 'キャンセル',
    Function? buttonAction,
    bool barrierDismissible = false,
    bool isShowButton = true,
    bool isShowRejectButton = false,
    String? detailLink,
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
            width: 160,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 50,
                  color: ColorName.mainthemeColor,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 30,
                    width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: CustomText(
                          text: title,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: detailLink != null
                                          ? () async {
                                              Uri url = Uri.parse(detailLink);
                                              if (!(await canLaunchUrl(url))) {
                                                Log.echo('URLを開けませんでした。',
                                                    symbol: '❌');
                                                return;
                                              }
                                              await launchUrl(url);
                                            }
                                          : null,
                                      child: CustomText(
                                        underLines:
                                            detailLink == null ? false : true,
                                        text: detail,
                                        color: detailLink == null
                                            ? null
                                            : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (isShowButton) ...[
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
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop();
                                      },
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (isShowRejectButton) ...[
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomButton(
                                  primaryColor: ColorName.textBlack,
                                  text: rejectButtonText,
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();
                                  }),
                            ),
                          ),
                        ),
                      ]
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
