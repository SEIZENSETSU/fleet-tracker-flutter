import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_arrow.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';

class DestinationCard extends StatefulWidget {
  DestinationCard({
    super.key,
    required this.title,
    required this.delayStateType,
    required this.angle,
    required this.distance,
  });
  final String title;
  final String delayStateType;
  final int angle;
  final double distance;

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  @override
  Widget build(BuildContext context) {
    WarehouseDelayStateType stateType =
        WarehouseDelayStateType(widget.delayStateType);
    return Container(
      height: 300,
      width: 300,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorName.destinationShadowColor,
            spreadRadius: 1.0,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: DestinationArrow(
                  angle: widget.angle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: CustomText(
                          text: widget.title,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Center(
                          child: CustomText(text: '${widget.distance}km')),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      color: stateType.color(),
                      child: Center(
                        child: CustomText(
                          color: Colors.white,
                          text: stateType.title()!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
