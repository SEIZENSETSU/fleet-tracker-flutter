import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/prefectural_road_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    double _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      width: _deviceWidth,
      child: ExpansionTile(
        trailing: Container(
          width: _deviceWidth * 0.2,
          height: _deviceWidth * 0.08,
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                width: 1,
                color: Colors.blue,
              ),
              top: BorderSide(
                width: 1,
                color: Colors.blue,
              ),
            ),
          ),
          child: const FittedBox(
            alignment: Alignment.centerRight,
            fit: BoxFit.fitHeight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 8,
              ),
              child: Icon(
                Icons.expand_more,
                color: ColorName.mainthemeColor,
              ),
            ),
          ),
        ),
        tilePadding: EdgeInsets.all(0),
        title: Container(
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                width: 1,
                color: Colors.red,
              ),
              top: BorderSide(
                width: 1,
                color: Colors.red,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: _deviceWidth * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(imageUrl),
                ),
              ),
              SizedBox(
                width: _deviceWidth * 0.3,
                height: _deviceWidth * 0.06,
                child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                    child: CustomText(
                      text: prefectureName,
                    )),
              ),
              SizedBox(
                width: _deviceWidth * 0.2,
                height: _deviceWidth * 0.06,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fitHeight,
                  child: CustomText(text: '${count}件'),
                ),
              ),
            ],
          ),
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
