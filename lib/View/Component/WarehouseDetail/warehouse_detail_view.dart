import 'dart:math';

import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Component/warehouse_detail_controller.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/comment.dart';
import 'package:fleet_tracker/Model/Entity/delay_time_detail.dart';
import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/Service/API/Original/comment_service.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/circular_progress_indicator_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_textfield.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/spacer_and_divider.dart';
import 'package:fleet_tracker/View/Component/WarehouseDetail/comment_tile.dart';
import 'package:fleet_tracker/View/Component/WarehouseDetail/warehouse_map.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../Constants/Enum/warehouse_delay_state_enum.dart';
import '../../../Model/Data/Warehouse/search_info_data.dart';
import '../../../Model/Entity/Warehouse/info.dart';

class WarehouseDetailView extends StatefulWidget {
  const WarehouseDetailView(
      {super.key, required this.warehouseInfo, required this.functionType});
  final String functionType;
  final WarehouseInfo warehouseInfo;
  @override
  State<WarehouseDetailView> createState() => _WarehouseDetailViewState();
}

class _WarehouseDetailViewState extends State<WarehouseDetailView> {
  WarehouseDetailController controller = WarehouseDetailController();
  @override
  Widget build(BuildContext context) {
    /// コメント投稿と遅延情報登録の可否判定
    controller.initialize(widget.functionType);
    final Size size = MediaQuery.of(context).size;
    WarehouseDelayStateType stateType =
        WarehouseDelayStateType(widget.warehouseInfo.averageDelayState.name);

    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        isBackButton: true,
        title: widget.warehouseInfo.warehouseName,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //
              // 倉庫のマップ表示部
              FutureBuilder(
                future: WarehouseService().getWarehouseInfo(
                    warehouseId: widget.warehouseInfo.warehouseId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const CirclarProgressIndicatorCell(height: 130);
                  }
                  if (snapshot.hasData) {
                    return WarehouseMap(
                      latitude: snapshot.data!.latitude,
                      longitude: snapshot.data!.longitude,
                    );
                  } else {
                    return const CirclarProgressIndicatorCell(height: 130);
                  }
                },
              ),

              const SpacerAndDivider(topHeight: 10, bottomHeight: 10),

              //
              // 倉庫遅延状況セル表示部分
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: Strings.DELAY_STATUS,
                    color: ColorName.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CommonCard(
                    content: UserInputCell(
                      warehouseName: widget.warehouseInfo.warehouseName,
                      traficstateCountList:
                          widget.warehouseInfo.delayTimeDetails,
                      delayStateType:
                          widget.warehouseInfo.averageDelayState.name,
                      enableAction: controller.enableAction,
                      warehouseId: widget.warehouseInfo.warehouseId,
                      warehouseAreaId: widget.warehouseInfo.warehouseAreaId,
                    ),
                  ),
                ),
              ),
              const SpacerAndDivider(topHeight: 10, bottomHeight: 10),
              //
              // 操作ボタン表示部分
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: Strings.OPERATION_ACTIONS,
                    color: ColorName.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: size.width * 0.95,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        heightFactor: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CommonCard(
                            onTap: () async {
                              await controller.favoriteButtonAction(
                                warehouseId: widget.warehouseInfo.warehouseId,
                              );
                            },
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 5),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: CustomText(text: 'お気に入り'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SpacerAndDivider(topHeight: 10, bottomHeight: 10),
              //
              // コメント表示部
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: Strings.TWEET_ABOUT_FACTORY,
                    color: ColorName.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
              FutureBuilder(
                  future: controller.getCommentList(
                      warehouseId: widget.warehouseInfo.warehouseId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CirclarProgressIndicatorCell(height: 400);
                    }

                    if (snapshot.hasData) {
                      final List<Map<String, dynamic>> comentList =
                          snapshot.data!;
                      Log.echo(comentList.length.toString());
                      if (comentList.isNotEmpty) {
                        return Container(
                          height: 400,
                          color: ColorName.commentAreaBackground,
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: CommentTile(
                                    userComment: comentList[index]['comment'],
                                    createAt: DateFormat(
                                            'yyyy年MM月dd日 hh時mm分', 'ja_JP')
                                        .format(DateTime.parse(
                                            comentList[index]['create_at'])),
                                    userName: comentList[index]['name'],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Container(
                          height: 400,
                          color: Colors.white,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.comments_disabled,
                                  size: 50,
                                ),
                                CustomText(text: '現在この工場に対するつぶやきはありません。'),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return CirclarProgressIndicatorCell(height: 400);
                    }
                  }),
              Visibility(
                visible: controller.enableAction,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: ColorName.mainthemeColor.withAlpha(60),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextfield(
                            isSerchIcon: false,
                            hintText: 'コメントを書いてください',
                            backgroundcolor: Colors.white,
                            controller: controller.textEditingController),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size.width,
                            child: CustomButton(
                              isFilledColor: true,
                              primaryColor: ColorName.mainthemeColor,
                              text: '投稿',
                              onTap: () async {
                                controller.postComment(
                                  content:
                                      controller.textEditingController.text,
                                  warehouseId: widget.warehouseInfo.warehouseId,
                                );
                                setState(() {});
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
