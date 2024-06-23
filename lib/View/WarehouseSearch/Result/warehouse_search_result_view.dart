import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';
import '../../Component/CustomWidget/Card/common_card.dart';

class WarehouseSearchResultView extends StatefulWidget {
  const WarehouseSearchResultView({
    super.key,
    this.area,
    this.areaId,
    this.keyword,
  });

  final String? area;
  final int? areaId;
  final String? keyword;

  @override
  State<WarehouseSearchResultView> createState() =>
      _WarehouseSearchResultViewState();
}

class _WarehouseSearchResultViewState extends State<WarehouseSearchResultView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: '検索結果',
        isBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: '倉庫一覧',
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              height: 50,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: ColorName.mainthemeColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  CustomText(
                    text: widget.area!,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // エリアの数
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.my_location),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomText(text: '東関東エリア'),
                            ),
                          ],
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // エリア内にある倉庫の数
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * 0.1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: CommonCard(
                                  content: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: Container(
                                            child: Assets
                                                .images.component.factoryIcon
                                                .image(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              CustomText(
                                                text: 'エルフーズ東京',
                                                fontSize: 13,
                                              ),
                                              const Spacer(),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                child: const Icon(
                                                  Icons.chevron_right,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
