import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Component/CustomWidget/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackground,
      appBar: CustomAppBar(
        title: 'ホーム',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              // エリアの天気情報の表示部
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '現在地・現在時刻',
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 100,
              ),
              //
              // 近くのエリア表示部
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '現在地から一番近くのエリア',
                    fontSize: 14,
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(height: 400, color: Colors.white),
                  DestinationCard(
                    title: '東関東エリア',
                    delayStateType: 'normal',
                    angle: 60,
                    distance: 50.4,
                  ),
                ],
              ),
              //
              // エリアの天気情報の表示部
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'エリアの天気',
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 100,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: 80,
                      child: CommonCard(
                        content: Row(
                          children: [
                            CustomText(
                              text: '現在',
                              fontSize: 10,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.red,
                              child: Image.asset(
                                Assets.images.component.sunIcon.path,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: 80,
                      child: CommonCard(
                        content: CustomText(text: 'bbb'),
                      ),
                    ),
                  ],
                ),
              ),
              //
              // 各ページへの遷移ボタン
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: '機能',
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: CommonCard(
                        onTap: () {
                          // 倉庫検索タブへ遷移
                        },
                        content: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                            ),
                            CustomText(
                              text: '倉庫検索',
                              fontSize: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: CommonCard(
                        onTap: () {
                          // コメント・遅延登録画面へ遷移
                        },
                        content: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat,
                            ),
                            CustomText(
                              text: '登録',
                              fontSize: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: CommonCard(
                        onTap: () {
                          // 交通情報タブへ遷移
                        },
                        content: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                            ),
                            CustomText(
                              text: '交通情報',
                              fontSize: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: CommonCard(
                        onTap: () {
                          // 設定タブへ遷移
                        },
                        content: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                            ),
                            CustomText(
                              text: '設定',
                              fontSize: 8,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
