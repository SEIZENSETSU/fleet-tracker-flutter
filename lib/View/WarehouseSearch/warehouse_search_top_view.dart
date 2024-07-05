import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/WarehouseSearch/warehouse_search_top_controller.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/info.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/japan_map_deformed.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/local_search_card_group.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/circular_progress_indicator_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_textfield.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/spacer_and_divider.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Model/Entity/Warehouse/warehouse.dart';
import '../../Route/router.dart';
import '../Component/CustomWidget/custom_text.dart';

class WarehouseSearchTopView extends StatefulWidget {
  const WarehouseSearchTopView({super.key});

  @override
  State<WarehouseSearchTopView> createState() =>
      __WarehouseSearchTopViewState();
}

class __WarehouseSearchTopViewState extends State<WarehouseSearchTopView> {
  WarehouseSearchTopController controller = WarehouseSearchTopController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: '倉庫検索',
        actions: [
          IconButton(
            onPressed: () async {
              await controller.setMapSwitch(flag: !controller.mapSwitch);
              setState(() {});
            },
            icon: Icon(
              Icons.grid_view,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //
            // キーワードから探す表示部分
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: Strings.SEARCH_WITH_KEYWORD,
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  hintText: '工場名、エリア名、地名',
                  backgroundcolor: Colors.white,
                  controller: controller.textEditingController,
                  isSerchIcon: true,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: size.width * 0.8,
              child: CustomButton(
                isFilledColor: true,
                primaryColor: ColorName.mainthemeColor,
                text: '検索',
                onTap: () {
                  // キーワード検索で検索結果画面にいく
                  bool check = controller.validationCheck(
                      keyword: controller.textEditingController.text);
                  if (check) {
                    WarehouseSearchResultRoute(
                            keyword: controller.textEditingController.text)
                        .push(context);
                  }
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SpacerAndDivider(topHeight: 20, bottomHeight: 10),
            //
            // 地方から探す表示部分
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: Strings.SEARCH_WITH_REGION,
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            Visibility(
              visible: !controller.mapSwitch,
              child: SizedBox(
                width: size.width,
                height: size.width,
                child: LocalSearchCardGroup(
                    areaNameList: controller.areaNameList,
                    setState: () {
                      setState(() {});
                    }),
              ),
            ),
            Visibility(
              visible: controller.mapSwitch,
              child: JapanMapDefomed(
                setState: () {
                  setState(() {});
                },
              ),
            ),
            const SpacerAndDivider(topHeight: 20, bottomHeight: 10),
            //
            // お気に入りから探す表示部分
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: Strings.SEARCH_WITH_FAVORITE,
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            // 表示部
            FutureBuilder(
                future: controller.getFavoriteWarehouses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CirclarProgressIndicatorCell(height: 100);
                  }

                  if (snapshot.hasData) {
                    List<WarehouseInfo> warehosueInfo = snapshot.data!;
                    if (warehosueInfo.isEmpty) {
                      return Container(
                        height: 300,
                        color: Colors.white,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_shipping,
                                size: 60,
                              ),
                              CustomText(
                                text: 'お気に入りに登録された工場はありません。',
                                fontSize: 15,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: warehosueInfo.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                // 倉庫詳細ページへ遷移

                                Log.echo('倉庫詳細ページへ');

                                // お気に入り工場リストからインスタンス化して値を渡す

                                WarehouseDetailRoute(
                                  $extra: warehosueInfo[index],
                                  functionType: FunctionTypeEnum.search.name,
                                ).push(context).then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              },
                              child: SizedBox(
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
                                                  .images.icons.factoryIcon
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
                                                  text: warehosueInfo[index]
                                                      .warehouseName,
                                                  fontSize: 13,
                                                ),
                                                Spacer(),
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
                              ),
                            );
                          });
                    }
                  } else {
                    return const CirclarProgressIndicatorCell(height: 100);
                  }
                }),

            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
