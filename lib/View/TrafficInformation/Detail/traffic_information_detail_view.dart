import 'package:fleet_tracker/Controller/TrafficInformation/Detail/traffic_information_detail_controller.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/info_content_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_place_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_title.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_header.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrafficInformationDetailView extends StatefulWidget {
  const TrafficInformationDetailView({
    super.key,
    required this.roadId,
    required this.provideSapa,
  });
  final int roadId;
  final bool provideSapa;

  @override
  State<TrafficInformationDetailView> createState() =>
      _TrafficInformationStateDetailView();
}

class _TrafficInformationStateDetailView
    extends State<TrafficInformationDetailView> {
  TrafficInformationDetailController trafficInformationDetailController =
      TrafficInformationDetailController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButton: true,
      ),
      backgroundColor: ColorName.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>?>(
                future: trafficInformationDetailController
                    .getRoadInfoMap(widget.roadId),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> roadInfoMap = snapshot.data!;
                    print(roadInfoMap);
                    return JamInfoTitle(
                      areaName: roadInfoMap['areaName'],
                      roadName: roadInfoMap['roadName'],
                      time: roadInfoMap['time'],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Map<String, dynamic>>?>(
                future: trafficInformationDetailController
                    .getJamInfoList(widget.roadId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> jamInfoList = snapshot.data!;
                    print(jamInfoList);
                    return InfoContentCard(
                      children: <Widget>[
                        for (int i = 0; i < 2; i++) ...{
                          JamInfoPlaceTile(
                            direction: jamInfoList[i]['direction'],
                            place: jamInfoList[i]['place'],
                            type: jamInfoList[i]['type'],
                            supplementInfo: jamInfoList[i]['supplementInfo'],
                          ),
                        },
                      ],
                      title: '渋滞情報',
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: widget.provideSapa,
              child: InfoContentCard(
                children: <Widget>[
                  SapaInfoHeader(),
                  for (int i = 0; i < 5; i++) ...{
                    SapaInfoTile(),
                  },
                ],
                title: 'SAPA情報',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
