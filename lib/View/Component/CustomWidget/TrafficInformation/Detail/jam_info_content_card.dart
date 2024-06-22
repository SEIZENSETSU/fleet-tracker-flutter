import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';

class JamInfoContentCard extends StatelessWidget {
  const JamInfoContentCard(
      {super.key, required this.children, required this.title});

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 20,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Container(
          width: deviceWidth,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: deviceWidth,
                decoration: BoxDecoration(
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
