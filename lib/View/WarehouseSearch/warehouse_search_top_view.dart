import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/japan_map_deformed.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/WarehouseSearch/japan_map_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: '地方から探す',
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            JapanMapDefomed(size: size),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'キーワードから探す',
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              height: size.height * 0.2,
              width: size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // フォーカス関連は時間かかるのでスキップ
                  // autofocus: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
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
          ],
        ),
      ),
    );
  }
}
