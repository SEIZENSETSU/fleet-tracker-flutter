import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class JamInfoTitle extends StatelessWidget {
  const JamInfoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: ColorName.jamInfoTitleColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: deviceWidth,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 6,
                left: 6,
                right: 10,
              ),
              child: Container(
                width: deviceWidth * 0.18,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                        text: '関東',
                        color: ColorName.jamInfoTitleColor,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      CustomText(
                        text: '東京湾アクアライン',
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: CustomText(
                    text: '最終更新 19:30 (JST)',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
