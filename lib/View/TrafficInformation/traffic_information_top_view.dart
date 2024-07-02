import 'package:fleet_tracker/Controller/TrafficInformation/traffic_information_top_controller.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/traffic_information_accordion_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:flutter/material.dart';

class TrafficInformationTopView extends StatefulWidget {
  const TrafficInformationTopView({super.key});

  @override
  State<TrafficInformationTopView> createState() =>
      _TrafficInformationStateTopViewState();
}

class _TrafficInformationStateTopViewState
    extends State<TrafficInformationTopView> {
  String imageUrl = 'https://www.c-ihighway.jp/smp/img/MAP/hokkaido.png';
  int count = 50;
  TrafficInformationTopController trafficInformationTopController =
      TrafficInformationTopController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: trafficInformationTopController.getPrefectureInfoList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> prefectureInfoList = snapshot.data!;
            return ListView.builder(
              itemCount: prefectureInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                String prefectureName = prefectureInfoList[index]['name'];
                List<Map> prefecturalRoadList =
                    prefectureInfoList[index]['roads'];

                return TrafficInformationTileCell(
                  imageUrl: imageUrl,
                  count: prefectureInfoList[index]['totalIssues'],
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
    );
  }
}
