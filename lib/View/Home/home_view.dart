import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/weather_state_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Home/home_controller.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Service/API/Original/warehouse_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Model/Data/Warehouse/search_info_data.dart';
import '../../Model/Entity/Warehouse/warehouse.dart';
import '../../Route/router.dart';
import '../Component/CustomWidget/UserInput/user_input_cell.dart';
import '../Component/CustomWidget/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();
  String currentAddress = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(
      () async {
        currentAddress = await controller.getCurrentAddress();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final warehouseSearchInfo = ref.watch(warehouseSearchInfoDataProvider);
      final _data = warehouseSearchInfo.getData();

      if (_data.isInvading) {
        return Scaffold(
          backgroundColor: ColorName.scaffoldBackground,
          appBar: CustomAppBar(
            title: 'ホーム',
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final data in _data.warehouses!)
                    Container(
                      width: size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CommonCard(
                          content: UserInputCell(
                            warehouseAreaId: data.warehouseAreaId,
                            warehouseName: data.warehouseName,
                            warehouseId: data.warehouseId,

                            /// 後ほど
                            traficstateCountList: data.delayTimeDetails,
                            delayStateType: data.averageDelayState.name,
                            toWarehousePage: () {
                              WarehouseDetailRoute(
                                $extra: data,
                                functionType: 'search',
                              ).push(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Consumer(builder: (context, ref, _) {
          final locationInfo = ref.watch(locationDataProvider);
          final _location = locationInfo.getData();

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
                    // 現在時刻・現在地の表示部
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: Strings.CURRENT_LOCATION_AND_TIME,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 100,
                      child: SizedBox(
                        width: size.width * 0.9,
                        child: CommonCard(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: size.width * 0.5,
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: const Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomText(
                                          text: '現在地',
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CustomText(
                                          text: currentAddress,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 4.0,
                                        ),
                                        child: FutureBuilder<String?>(
                                            future: controller.getNearestRoadName(lat: _location.lat, lng: _location.lng),
                                            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                              return CustomText(
                                                text: snapshot.data ?? '高速道路名',
                                                fontSize: 12,
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.3,
                                height: 70,
                                color: const Color.fromARGB(255, 232, 231, 231),
                                child: const FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: CustomText(
                                      text: '10:00',
                                      color: ColorName.mainthemeColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //
                    // 近くのエリア表示部
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: Strings.NEAR_BY_AREAS,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 400,
                          color: Colors.white,
                        ),
                        DestinationCard(
                          title: _data.warehouseAreas![0].warehouseAreaName,
                          delayStateType: _data.warehouseAreas![0].averageDelayState.name,
                          angle: 60,
                          distance: _data.warehouseAreas![0].distance,
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
                              cardColor: WeatherStateType('sun').color(),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: CustomText(
                                            text: '現在の天気',
                                            fontSize: 10,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomText(
                                            text: WeatherStateType('sun').title(),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Padding(
                                          padding: const EdgeInsets.all(50.0),
                                          child: WeatherStateType('sun').image(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            child: const Icon(
                              Icons.arrow_forward,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            height: 80,
                            child: CommonCard(
                              cardColor: WeatherStateType('rain').color(),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: CustomText(
                                            text: '1時間後の天気',
                                            fontSize: 10,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomText(
                                            text: WeatherStateType('rain').title(),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Padding(
                                          padding: const EdgeInsets.all(50.0),
                                          child: WeatherStateType('rain').image(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                          text: Strings.APP_FUNCTION,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: size.width * 0.9,
                      decoration: const BoxDecoration(
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
                                controller.pushFunctionCard(FunctionType('home').branchIndex());
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
                                controller.pushFunctionCard(FunctionType('userInput').branchIndex());
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
                                controller.pushFunctionCard(FunctionType('trafficInformation').branchIndex());
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
                                controller.pushFunctionCard(FunctionType('setting').branchIndex());
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
                    ),
                    //
                    // 余白
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          );
        });
      }
    });
  }
}
