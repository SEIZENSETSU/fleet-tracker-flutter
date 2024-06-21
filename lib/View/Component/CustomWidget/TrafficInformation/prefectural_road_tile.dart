import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrefecturalRoadTile extends StatelessWidget {
  const PrefecturalRoadTile({super.key, required this.prefecturalRoadName});

  final String prefecturalRoadName;

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        print(prefecturalRoadName);
      },
      child: Container(
        width: _deviceWidth,
        height: _deviceWidth * 0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _deviceWidth * 0.2,
            ),
            Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              width: _deviceWidth * 0.8,
              height: _deviceWidth * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: _deviceWidth * 0.6,
                    height: _deviceWidth * 0.06,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      child: CustomText(
                        text: prefecturalRoadName,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _deviceWidth * 0.1,
                    height: _deviceWidth * 0.06,
                    child: Visibility(
                      visible: true,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.fitHeight,
                        child: Icon(
                          Icons.warning,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _deviceWidth * 0.1,
                    height: _deviceWidth * 0.05,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: ColorName.mainthemeColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
