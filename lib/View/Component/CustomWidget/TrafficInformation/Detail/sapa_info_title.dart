import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class SapaInfoTitle extends StatelessWidget {
  const SapaInfoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
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
              Padding(
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
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.pedal_bike,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.drive_eta,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
