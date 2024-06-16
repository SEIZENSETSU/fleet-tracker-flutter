import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({
    super.key,
    required this.contentList,
  });

  List<Widget> contentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.mainthemeColor,
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: contentList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
