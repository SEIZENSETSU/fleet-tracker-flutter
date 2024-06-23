import 'package:fleet_tracker/Model/Entity/warehouse.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/View/Component/WarehouseDetail/comment_tile_cell.dart';
import 'package:fleet_tracker/View/Component/WarehouseDetail/warehouse_map.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Constants/Enum/warehouse_delay_state_enum.dart';

class WarehouseDetailView extends StatefulWidget {
  const WarehouseDetailView({
    super.key,
    required this.warehouse,
    required this.traficstateCount,
    required this.delayStateType,
  });
  final Warehouse warehouse;
  final List traficstateCount;
  final String delayStateType;
  @override
  State<WarehouseDetailView> createState() => _WarehouseDetailViewState();
}

class _WarehouseDetailViewState extends State<WarehouseDetailView> {
  List commentList = [0, 0, 0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WarehouseDelayStateType stateType =
        WarehouseDelayStateType(widget.delayStateType);
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        isBackButton: true,
        title: widget.warehouse.name,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //
              // 倉庫のマップ表示部

              WarehouseMap(
                latitude: widget.warehouse.latitude,
                longitude: widget.warehouse.longitude,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              //
              // 倉庫遅延状況セル表示部分
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '遅延状況',
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
                      warehouseName: widget.warehouse.name,
                      traficstateCount: widget.traficstateCount,
                      delayStateType: widget.delayStateType,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              //
              // 操作ボタン表示部分
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '操作',
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
                        child: GestureDetector(
                          onTap: () {
                            // お気に入り登録
                            Log.echo('${widget.warehouse.name}をお気に入り登録をしました');
                          },
                          child: const Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CommonCard(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 5),
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
                    ),
                    //
                    // 工場への操作が今のところ未定なため隠す
                    // ここ剥がせば綺麗に二つ横並び
                    // Expanded(
                    //   flex: 1,
                    //   child: FractionallySizedBox(
                    //     heightFactor: 1,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         // 何にしようかな
                    //         Log.echo('${widget.warehouse.areaId}を表示とかでもいい？');
                    //       },
                    //       child: const Padding(
                    //         padding: const EdgeInsets.all(4.0),
                    //         child: CommonCard(
                    //           content: Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               Padding(
                    //                 padding:
                    //                     EdgeInsets.only(left: 10, right: 5),
                    //                 child: Icon(
                    //                   Icons.factory,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: CustomText(text: '倉庫情報'),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              //
              // コメント表示部
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'この工場に関するつぶやき',
                    color: ColorName.textBlack,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 400,
                color: const Color.fromRGBO(221, 221, 221, 1),
                child: ListView.builder(
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      if (commentList.length != 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: CommentTileCell(
                            userComment: 'なんか遅延してたよここ',
                            createAt: '2024年6月21日 9時20分',
                            userName: '充電コード無くした人',
                          ),
                        );
                      } else {
                        return CustomText(text: 'この工場へのつぶやきはまだありません。');
                      }
                    }),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: ColorName.mainthemeColor.withAlpha(60),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            // フォーカス関連は時間かかるのでスキップ
                            // autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                              text: '投稿',
                              isFilledColor: true,
                              primaryColor: ColorName.mainthemeColor,
                              onTap: () {
                                // コメントを投稿する
                                Log.toast('コメントを投稿しました');
                              }),
                        ),
                      ),
                    ),
                  ],
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
