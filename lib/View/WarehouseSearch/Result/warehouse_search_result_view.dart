import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/WarehouseSearch/warehouse_search_top_controller.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/circular_progress_indicator_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Controller/WarehouseSearch/Result/warehouse_search_result_controller.dart';
import '../../../Model/Entity/Warehouse/warehouse.dart';
import '../../../Route/router.dart';
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
  final List<int>? areaId;
  final String? keyword;

  @override
  State<WarehouseSearchResultView> createState() =>
      _WarehouseSearchResultViewState();
}

class _WarehouseSearchResultViewState extends State<WarehouseSearchResultView> {
  WarehouseSearchResultController controller =
      WarehouseSearchResultController();
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
                  text: Strings.WAREHOUSE_LIST,
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            //
            // 地域検索かキーワード検索かで切り替える
            if (widget.area != null)
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
            if (widget.keyword != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 50,
                  width: size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                      ),
                      CustomText(
                        text: '"${widget.keyword!}"を含む',
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 100,
                ),
                width: size.width,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.my_location),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomText(text: '${widget.area}エリア'),
                        ),
                      ],
                    ),
                    FutureBuilder(
                        future: controller.getWarehouseWithArea(
                            areaIds: widget.areaId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const CirclarProgressIndicatorCell(
                                height: 300);
                          }

                          if (snapshot.hasData) {
                            List<Warehouse>? warehouseList = snapshot.data;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,

                              // エリア内にある倉庫の数
                              itemCount: warehouseList!.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: size.height * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: CommonCard(
                                      onTap: () {
                                        // カードをタップして倉庫詳細ページへ遷移
                                        // WarehouseDetailRoute(
                                        //   $extra: Warehouse(
                                        //     id: 1,
                                        //     name: 'エルフーズ東京',
                                        //     latitude: 35.681236,
                                        //     longitude: 139.767125,
                                        //   ),
                                        //   traficstateCountList: [],
                                        //   delayStateType: 'pause',
                                        // ).push(context);
                                      },
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
                                                    text: warehouseList[index]
                                                        .name,
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
                            );
                          } else {
                            return const CirclarProgressIndicatorCell(
                                height: 300);
                          }
                        })
                  ],
                ),
              ),
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
