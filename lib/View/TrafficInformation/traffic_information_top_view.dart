import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_arrow.dart';
import 'package:fleet_tracker/View/Component/CustomScaffold/custom_scaffold.dart';
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
      for (int i = 0; i < 10; i++) CommonCell(title: 'title $i'),
    ];
    return CustomScaffold(contentList: cellList);
  }
}
