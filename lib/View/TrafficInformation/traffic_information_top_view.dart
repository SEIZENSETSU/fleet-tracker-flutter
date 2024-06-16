import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';
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
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: ColorName.scaffoldBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              DestinationCard(
                title: '東京エリア',
                delayStateType: 'normal',
                angle: 0,
                distance: 90,
              ),
              SizedBox(
                height: 20,
              ),
              DestinationCard(
                title: '東北エリア',
                delayStateType: 'pause',
                angle: 90,
                distance: 10.2,
              ),
              SizedBox(
                height: 20,
              ),
              DestinationCard(
                title: '名古屋エリア',
                delayStateType: 'halfHour',
                angle: 30,
                distance: 8,
              ),
              SizedBox(
                height: 20,
              ),
              DestinationCard(
                title: '九州エリア',
                delayStateType: 'anHour',
                angle: 260,
                distance: 77.4,
              ),
              SizedBox(
                height: 20,
              ),
              DestinationCard(
                title: '北海道エリア',
                delayStateType: 'impossible',
                angle: 330,
                distance: 36,
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
