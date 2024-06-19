import 'package:fleet_tracker/View/Component/CustomWidget/Dialog/error_dialog.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
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
  List<String> area = [
    '北海道',
    '東北',
    '北陸・信越',
    '関東',
    '東海',
    '関西',
    '中国',
    '四国',
    '九州・沖縄'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(),
      body: ListView.builder(
          itemCount: area.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                ErrorDialog().showErrorDialog(
                    context: context,
                    title: '遅延情報なし',
                    content: Assets.images.trackColor.image(),
                    detail: '現在の遅延情報はありません。');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorName.destinationshadowColor,
                    ),
                  ),
                ),
                height: 50,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                    CustomText(
                      text: area[index],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
