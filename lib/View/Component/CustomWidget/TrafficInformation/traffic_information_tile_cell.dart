import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/prefectural_road_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class TrafficInformationTileCell extends StatelessWidget {
  const TrafficInformationTileCell({
    super.key,
    required this.imageUrl,
    required this.count,
    required this.prefectureName,
    required this.prefecturalRoadList,
    required this.index,
  });

  final String imageUrl;
  final int count;
  final String prefectureName;
  final List<String> prefecturalRoadList;
  final int index;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      width: deviceWidth,
      child: ExpansionTile(
        iconColor: Colors.grey,
        collapsedIconColor: ColorName.mainthemeColor,
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: <Widget>[
            SizedBox(
              width: deviceWidth * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(imageUrl),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.3,
              height: deviceWidth * 0.06,
              child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fitHeight,
                  child: CustomText(
                    text: prefectureName,
                  )),
            ),
            SizedBox(
              width: deviceWidth * 0.2,
              height: deviceWidth * 0.06,
              child: Visibility(
                visible: count != 0,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fitHeight,
                  child: CustomText(text: '${count}件'),
                ),
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: <Widget>[
              for (int i = 0; i < prefecturalRoadList.length; i++) ...{
                PrefecturalRoadTile(
                    prefecturalRoadName: prefecturalRoadList[i]),
              }
            ],
          ),
        ],
      ),
    );
  }
}
