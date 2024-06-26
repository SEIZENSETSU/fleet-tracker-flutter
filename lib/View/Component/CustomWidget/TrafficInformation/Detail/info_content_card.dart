import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class InfoContentCard extends StatelessWidget {
  const InfoContentCard(
      {super.key, required this.children, required this.title});

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: ColorName.destinationshadowColor,
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
          ],
        ),
        child: Container(
          width: deviceWidth,
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: deviceWidth,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: CustomText(
                    text: title,
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
