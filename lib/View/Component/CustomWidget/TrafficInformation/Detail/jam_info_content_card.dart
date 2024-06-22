import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_place_dell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class JamInfoContentCard extends StatelessWidget {
  const JamInfoContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: deviceWidth,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: deviceWidth,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: CustomText(
                    text: '渋滞状況',
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  for (int i = 0; i < 4; i++) ...{
                    JamInfoPlaceCell(),
                  }
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
