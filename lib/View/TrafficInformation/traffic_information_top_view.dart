import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_card.dart';
import 'package:fleet_tracker/View/Component/CustomScaffold/custom_scaffold.dart';
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
  @override
  Widget build(BuildContext context) {
    List<Widget> cellList = [
      for (int i = 0; i < 10; i++) DestinationCard(title: 'title $i'),
    ];
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: ColorName.scaffoldBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DestinationCard(title: 'あああ'),
          ],
        ),
      ),
    );
  }
}
