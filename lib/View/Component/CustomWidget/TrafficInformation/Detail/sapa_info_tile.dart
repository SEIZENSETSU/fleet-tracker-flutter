import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/Detail/sapa_info_congestion_icon.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class SapaInfoTile extends StatelessWidget {
  const SapaInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                    text: '那須高原SA',
                    fontSize: 18,
                    color: ColorName.sapaNameColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CustomText(
                    text: '(那須方向)',
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
                  child: SapaInfoCongestionIcon(congestion: '空'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: SapaInfoCongestionIcon(congestion: '空'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: SapaInfoCongestionIcon(congestion: '空'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
