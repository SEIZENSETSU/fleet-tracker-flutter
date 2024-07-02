import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class PrefecturalRoadTile extends StatelessWidget {
  const PrefecturalRoadTile(
      {super.key,
      required this.prefecturalRoadName,
      required this.roadIssues,
      required this.roadId});

  final String prefecturalRoadName;
  final bool roadIssues;
  final int roadId;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        TrafficInformationDetailRoute().push(context);
      },
      child: Container(
        width: deviceWidth,
        height: deviceWidth * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: deviceWidth * 0.1,
            ),
            Container(
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              width: deviceWidth * 0.9,
              height: deviceWidth * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: deviceWidth * 0.7,
                    height: deviceWidth * 0.06,
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
                    width: deviceWidth * 0.1,
                    height: deviceWidth * 0.06,
                    child: Visibility(
                      visible: roadIssues,
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
                    width: deviceWidth * 0.1,
                    height: deviceWidth * 0.05,
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
