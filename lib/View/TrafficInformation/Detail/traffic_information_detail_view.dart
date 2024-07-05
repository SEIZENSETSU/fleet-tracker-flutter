import 'package:fleet_tracker/Controller/TrafficInformation/Detail/traffic_information_detail_controller.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/detail.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/issue.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/sapa_info.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/info_content_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_place_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_title.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_header.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
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
  TrafficInformationDetailController controller =
      TrafficInformationDetailController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '道路情報',
        isBackButton: true,
      ),
      backgroundColor: ColorName.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<TrafficDetail?>(
                future: controller.getTrafficDetail(widget.roadId),
                builder: (BuildContext context,
                    AsyncSnapshot<TrafficDetail?> snapshot) {
                  if (snapshot.hasData) {
                    TrafficDetail trafficDetail = snapshot.data!;
                    return JamInfoTitle(
                      areaName: trafficDetail.data.areaName,
                      roadName: trafficDetail.data.roadName,
                      time: trafficDetail.summary.updateTimestamp,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<TrafficIssue>?>(
                future: controller.getTrafficIssueList(widget.roadId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TrafficIssue>?> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      List<TrafficIssue> trafficIssueList = snapshot.data!;
                      return InfoContentCard(
                        title: '渋滞情報',
                        children: <Widget>[
                          for (int i = 0; i < trafficIssueList.length; i++) ...{
                            JamInfoPlaceTile(
                              direction: trafficIssueList[i].direction,
                              place: trafficIssueList[i].place,
                              type: trafficIssueList[i].type,
                              content: trafficIssueList[i].content,
                              range: trafficIssueList[i].range,
                              reason: trafficIssueList[i].reason,
                            ),
                          },
                        ],
                      );
                    } else {
                      return InfoContentCard(
                        title: '渋滞情報',
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CustomText(
                                  text: '渋滞情報はありません',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<TrafficSapaInfo>?>(
                future: controller.getTrafficSapaInfoList(widget.roadId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TrafficSapaInfo>?> snapshot) {
                  if (widget.provideSapa) {
                    if (snapshot.hasData) {
                      List<TrafficSapaInfo> trafficSapaInfoList =
                          snapshot.data!;
                      return Column(
                        children: <Widget>[
                          InfoContentCard(
                            title: 'SAPA情報',
                            children: <Widget>[
                              SapaInfoHeader(),
                              for (int i = 0;
                                  i < trafficSapaInfoList.length;
                                  i++) ...{
                                SapaInfoTile(
                                  name: trafficSapaInfoList[i].name,
                                  direction: trafficSapaInfoList[i].direction,
                                  totalCongestion:
                                      trafficSapaInfoList[i].totalCongestion,
                                  smallCarCongestion:
                                      trafficSapaInfoList[i].smallCarCongestion,
                                  largeCarCongestion:
                                      trafficSapaInfoList[i].largeCarCongestion,
                                ),
                              },
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const Center(child: SizedBox());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
