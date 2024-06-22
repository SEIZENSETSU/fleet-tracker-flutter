import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_content_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/jam_info_title.dart';
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
      appBar: AppBar(
        backgroundColor: ColorName.mainthemeColor,
      ),
      backgroundColor: ColorName.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            JamInfoTitle(),
            JamInfoContentCard(),
          ],
        ),
      ),
    );
  }
}
