import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class JamInfoTitle extends StatelessWidget {
  const JamInfoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        width: _deviceWidth,
        child: Column(
          children: <Widget>[
            CustomText(
              text: '東京湾アクアライン',
              color: Colors.white,
            ),
            CustomText(
              text: '19時30分',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
