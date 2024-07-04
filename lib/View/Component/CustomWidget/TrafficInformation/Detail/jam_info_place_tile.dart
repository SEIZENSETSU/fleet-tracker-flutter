import 'package:fleet_tracker/Constants/Enum/traffic_detail_state_enum.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class JamInfoPlaceTile extends StatelessWidget {
  const JamInfoPlaceTile({
    super.key,
    required this.direction,
    required this.place,
    required this.type,
    required this.content,
    required this.range,
    required this.reason,
  });
  final String direction;
  final String place;
  final TrafficDetailState type;
  final String? content;
  final String? range;
  final String? reason;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              width: deviceWidth,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                        text: direction,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: CustomText(
                      text: place,
                      fontSize: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                        text: TrafficDetailStateType(type.name).JapaneseText(),
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: content == null ? range! : '$content : $reason',
                    fontSize: 20,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
