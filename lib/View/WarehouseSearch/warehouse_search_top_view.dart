import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/japan_map_deformed.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/japan_map_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_button.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Model/Entity/warehouse.dart';
import '../../Route/router.dart';
import '../Component/CustomWidget/custom_text.dart';

class WarehouseSearchTopView extends StatefulWidget {
  const WarehouseSearchTopView({super.key});

  @override
  State<WarehouseSearchTopView> createState() =>
      __WarehouseSearchTopViewState();
}

class __WarehouseSearchTopViewState extends State<WarehouseSearchTopView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: '倉庫検索',
        actions: [
          IconButton(
            onPressed: () {},
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
                  text: 'キーワードから探す',
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // フォーカス関連は時間かかるのでスキップ
                  // autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '工場名、エリア名、地名',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Noto_Sans_JP',
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: size.width * 0.8,
              child: CustomButton(
                isFilledColor: true,
                primaryColor: ColorName.mainthemeColor,
                text: '検索',
                onTap: () {
                  // キーワード検索で検索結果画面にいく
                  WarehouseSearchResultRoute(keyword: 'エルフーズ').push(context);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            //
            // 地方から探す表示部分
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: '地方から探す',
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            JapanMapDefomed(size: size),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            //
            // お気に入りから探す表示部分
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'お気に入りから探す',
                  color: ColorName.textBlack,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: 100),
              child: Flexible(
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // 倉庫詳細ページへ遷移

                          Log.echo('倉庫詳細ページへ');

                          //
                          // お気に入り工場リストからインスタンス化して値を渡す

                          WarehouseDetailRoute(
                            $extra: Warehouse(
                              id: 1,
                              areaId: 1,
                              name: 'エルフーズ東京',
                              latitude: 35.681236,
                              longitude: 139.767125,
                            ),
                            traficstateCount: [10, 2, 34, 1, 0],
                            delayStateType: 'pause',
                          ).push(context);
                        },
                        child: Container(
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
                                          Spacer(),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            child: Icon(
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
                    }),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
