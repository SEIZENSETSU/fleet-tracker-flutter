import 'dart:ui';

import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/warehouse_area_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/circular_progress_indicator_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import '../../../Controller/WarehouseSearch/Result/warehouse_search_result_controller.dart';
import '../../../Model/Entity/Warehouse/info.dart';
import '../../../Model/Entity/Warehouse/warehouse.dart';
import '../../../Route/router.dart';
import '../../../gen/assets.gen.dart';
import '../../Component/CustomWidget/Card/common_card.dart';

class WarehouseSearchResultView extends StatefulWidget {
  const WarehouseSearchResultView({
    super.key,
    this.area,
    this.areaIds,
    this.keyword,
  });

  final String? area;
  final List<int>? areaIds;
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
                child: SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search,
                      ),
                      CustomText(
                        text: '名前に"${widget.keyword!}"を含む',
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (widget.areaIds != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  width: size.width,
                  color: Colors.white,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.areaIds!.length,
                    itemBuilder: (context, index) {
                      int areaId = widget.areaIds![index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.my_location),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomText(
                                  text: widget.keyword == null
                                      ? WarehouseAreaType(areaId).name()
                                      : '結果一覧',
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder(
                            future:
                                controller.getWarehouseWithArea(areaId: areaId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const CirclarProgressIndicatorCell(
                                    height: 300);
                              }

                              if (snapshot.hasData) {
                                List<Warehouse>? warehouseList = snapshot.data;
                                if (warehouseList!.isEmpty) {
                                  return const SizedBox(
                                    height: 400,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_off,
                                            size: 60,
                                          ),
                                          CustomText(
                                            text: '該当する工場は見つかりませんでした。',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,

                                    // エリア内orキーワードに該当する倉庫の数
                                    itemCount: warehouseList.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: size.height * 0.1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: CommonCard(
                                            onTap: () async {
                                              // カードをタップして倉庫詳細ページへ遷移
                                              WarehouseInfo? extra =
                                                  await controller
                                                      .getWarehouseInfo(
                                                          warehouseId:
                                                              warehouseList[
                                                                      index]
                                                                  .id);

                                              if (extra == null) {
                                                // エラー表示
                                                Log.toast('通信エラーです');
                                              }

                                              WarehouseDetailRoute(
                                                      $extra: extra!,
                                                      functionType:
                                                          FunctionTypeEnum
                                                              .search.name)
                                                  .push(context);
                                            },
                                            content: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: FractionallySizedBox(
                                                    heightFactor: 0.5,
                                                    child: Container(
                                                      child: Assets.images.icons
                                                          .factoryIcon
                                                          .image(),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            warehouseList[index]
                                                                .name,
                                                        fontSize: 13,
                                                      ),
                                                      const Spacer(),
                                                      const SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: Icon(
                                                          Icons.chevron_right,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                return const CirclarProgressIndicatorCell(
                                    height: 300);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            if (widget.keyword != null)
              FutureBuilder(
                future: controller.getWarehouseWithKeyword(
                    keyword: widget.keyword!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CirclarProgressIndicatorCell(height: 300);
                  }

                  if (snapshot.hasData) {
                    List<Warehouse>? warehouseList = snapshot.data;
                    if (warehouseList!.isEmpty) {
                      return const SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 60,
                              ),
                              CustomText(
                                text: '該当する工場は見つかりませんでした。',
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        // エリア内orキーワードに該当する倉庫の数
                        itemCount: warehouseList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: size.height * 0.1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: CommonCard(
                                onTap: () async {
                                  // カードをタップして倉庫詳細ページへ遷移
                                  WarehouseInfo? extra =
                                      await controller.getWarehouseInfo(
                                          warehouseId: warehouseList[index].id);

                                  if (extra == null) {
                                    // エラー表示
                                    Log.toast('通信エラーです');
                                  }

                                  WarehouseDetailRoute(
                                          $extra: extra!,
                                          functionType:
                                              FunctionTypeEnum.search.name)
                                      .push(context);
                                },
                                content: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: Container(
                                          child: Assets.images.icons.factoryIcon
                                              .image(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: warehouseList[index].name,
                                            fontSize: 13,
                                          ),
                                          const Spacer(),
                                          const SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Icon(
                                              Icons.chevron_right,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return const CirclarProgressIndicatorCell(height: 300);
                  }
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
