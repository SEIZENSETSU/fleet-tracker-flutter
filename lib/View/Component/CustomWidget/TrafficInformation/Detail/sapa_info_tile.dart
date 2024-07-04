import 'package:fleet_tracker/Constants/Enum/congestion_type_enum.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_congestion_icon.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SapaInfoTile extends StatelessWidget {
  const SapaInfoTile({
    super.key,
    required this.name,
    required this.direction,
    required this.totalCongestion,
    required this.smallCarCongestion,
    required this.largeCarCongestion,
  });
  final String name;
  final String direction;
  final String totalCongestion;
  final String smallCarCongestion;
  final String largeCarCongestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CustomText(
                    text: name,
                    fontSize: 18,
                    color: ColorName.sapaNameColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CustomText(
                    text: direction,
                    fontSize: 12,
                    color: ColorName.sapaNameColor,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: SapaInfoCongestionIcon(
                    congestion: totalCongestion,
                    iconColor: CongestionType(totalCongestion).color(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: SapaInfoCongestionIcon(
                    congestion: smallCarCongestion,
                    iconColor: CongestionType(smallCarCongestion).color(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: SapaInfoCongestionIcon(
                    congestion: largeCarCongestion,
                    iconColor: CongestionType(largeCarCongestion).color(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
