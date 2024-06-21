import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
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
        TrafficInformationDetailRoute().push(context);
      },
      child: Container(
        width: _deviceWidth,
        height: _deviceWidth * 0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _deviceWidth * 0.1,
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
              width: _deviceWidth * 0.9,
              height: _deviceWidth * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: _deviceWidth * 0.7,
                    height: _deviceWidth * 0.06,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CustomText(
                          text: prefecturalRoadName,
                        ),
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
                        color: Colors.grey,
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
