import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SapaInfoHeader extends StatelessWidget {
  const SapaInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: CustomText(
              text: '名称',
              fontSize: 16,
            ),
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.family_restroom,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Assets.images.component.smallCarCongestionIcon
                      .image(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Assets.images.component.largeCarCongestionIcon
                      .image(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
