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
      body: Placeholder(),
    );
  }
}
