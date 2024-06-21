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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        width: _deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: _deviceWidth * 0.9,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: '圏央道',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            CustomText(
              text: '19時30分',
              color: Colors.black,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
