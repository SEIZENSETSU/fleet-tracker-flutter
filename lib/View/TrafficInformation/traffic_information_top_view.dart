import 'package:fleet_tracker/Controller/TrafficInformation/traffic_information_top_controller.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/area.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/road.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/traffic_information_accordion_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class TrafficInformationTopView extends StatefulWidget {
  const TrafficInformationTopView({super.key});

  @override
  State<TrafficInformationTopView> createState() =>
      _TrafficInformationStateTopViewState();
}

class _TrafficInformationStateTopViewState
    extends State<TrafficInformationTopView> {
  TrafficInformationTopController controller =
      TrafficInformationTopController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '交通情報',
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ColorName.scaffoldBackground,
        ),
        child: FutureBuilder<List<TrafficArea>?>(
          future: controller.getTraffiiAreatList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TrafficArea>?> snapshot) {
            if (snapshot.hasData) {
              List<TrafficArea> prefectureInfoList = snapshot.data!;
              return ListView.builder(
                itemCount: prefectureInfoList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == prefectureInfoList.length) {
                    return const SizedBox(
                      height: 50,
                    );
                  }
                  String prefectureName = prefectureInfoList[index].name;
                  int areaId = prefectureInfoList[index].id;
                  List<TrafficRoad> prefecturalRoadList =
                      prefectureInfoList[index].roads;
                  return TrafficInformationTileCell(
                    areaId: areaId,
                    count: prefectureInfoList[index].totalIssues,
                    prefectureName: prefectureName,
                    prefecturalRoadList: prefecturalRoadList,
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
