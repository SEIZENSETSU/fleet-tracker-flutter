import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/info_content_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_place_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_title.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_tile.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_header.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class TrafficInformationDetailView extends StatefulWidget {
  const TrafficInformationDetailView({super.key});

  @override
  State<TrafficInformationDetailView> createState() =>
      _TrafficInformationStateDetailView();
}

class _TrafficInformationStateDetailView
    extends State<TrafficInformationDetailView> {
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
            JamInfoTitle(),
            SizedBox(
              height: 20,
            ),
            InfoContentCard(
              children: <Widget>[
                for (int i = 0; i < 2; i++) ...{
                  JamInfoPlaceTile(),
                },
              ],
              title: '渋滞情報',
            ),
            SizedBox(
              height: 20,
            ),
            InfoContentCard(
              children: <Widget>[
                SapaInfoHeader(),
                for (int i = 0; i < 5; i++) ...{
                  SapaInfoTile(),
                },
              ],
              title: 'SAPA情報',
            ),
          ],
        ),
      ),
    );
  }
}
