import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/weather_state_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Home/home_controller.dart';
import 'package:fleet_tracker/Model/Data/clock_data.dart';
import 'package:fleet_tracker/Model/Data/location_data.dart';
import 'package:fleet_tracker/Service/Package/Location/geolocator_service.dart';
import 'package:fleet_tracker/Model/Entity/Warehouse/info.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/destination_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../Model/Data/Warehouse/search_info_data.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final warehouseSearchInfo = ref.watch(warehouseSearchInfoDataProvider);
      final _data = warehouseSearchInfo.getData();
      final locationInfo = ref.watch(locationDataProvider);
      final _location = locationInfo.getData();

      if (_data.isInvading) {
        return Scaffold(
          backgroundColor: ColorName.scaffoldBackground,
          appBar: CustomAppBar(
            title: 'ホーム',
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(
                  Icons.restart_alt_outlined,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                            SizedBox(
                              width: size.width * 0.5,
                              height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                        top: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.location_on,
                                                color: ColorName.mainthemeColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 4,
                                              ),
                                              child: FutureBuilder<String>(
                                                  future: controller
                                                      .getCurrentAddress(),
                                                  builder: (context, snapshot) {
                                                    return FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: CustomText(
                                                        text:
                                                            '${snapshot.data}',
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                        vertical: 7.0,
                                      ),
                                      child: FutureBuilder<String>(
                                        future: controller.getNearestRoadName(
                                          lat: _location.lat,
                                          lng: _location.lng,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CustomText(
                                              text: '取得中',
                                              fontSize: 12,
                                            );
                                          }
                                          return CustomText(
                                            text: '${snapshot.data}',
                                            fontSize: 12,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              height: 70,
                              color: const Color.fromARGB(255, 232, 231, 231),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Consumer(builder: (context, ref, _) {
                                    final clockInfo =
                                        ref.watch(clockDataProvider);
                                    final clock = clockInfo.getData();
                                    return FutureBuilder(
                                        future: controller.getNowTime(clock!),
                                        builder: (context, snapshot) {
                                          return CustomText(
                                            text: '${snapshot.data}',
                                            color: ColorName.splashMain,
                                          );
                                        });
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                          child: FutureBuilder<WeatherStateType?>(
                              future: controller.getWeatherState(
                                lat: _location.lat,
                                lng: _location.lng,
                                isAfterOneHour: false,
                              ),
                              builder: (context, snapshot) {
                                /// awaitしてる間とバグってnullの場合の処理
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.data == null) {
                                  return const CommonCard(
                                    cardColor: Colors.white,
                                    content: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return CommonCard(
                                  cardColor: snapshot.data!.color(),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
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
                                              text: snapshot.data!.title(),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: snapshot.data!.image(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
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
                          child: FutureBuilder<WeatherStateType?>(
                              future: controller.getWeatherState(
                                lat: _location.lat,
                                lng: _location.lng,
                                isAfterOneHour: true,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.data == null) {
                                  return const CommonCard(
                                    cardColor: Colors.white,
                                    content: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return CommonCard(
                                  cardColor: snapshot.data!.color(),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
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
                                              text: snapshot.data!.title(),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
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
                                              padding:
                                                  const EdgeInsets.all(50.0),
                                              child: snapshot.data!.image(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<WarehouseInfo>?>(
                    future: controller.getFavoriteWarehouses(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WarehouseInfo>?> snapshot) {
                      if (snapshot.hasData) {
                        List<WarehouseInfo> favoriteWarehousesList =
                            snapshot.data!;
                        return Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: 'お気に入りの倉庫',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            for (final data in favoriteWarehousesList)
                              SizedBox(
                                width: size.width * 0.95,
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: CommonCard(
                                    content: UserInputCell(
                                      warehouseAreaId: data.warehouseAreaId,
                                      warehouseName: data.warehouseName,
                                      warehouseId: data.warehouseId,

                                      /// 後ほど
                                      traficstateCountList:
                                          data.delayTimeDetails,
                                      delayStateType:
                                          data.averageDelayState.name,
                                      toWarehousePage: () {
                                        WarehouseDetailRoute(
                                          $extra: data,
                                          functionType:
                                              FunctionTypeEnum.home.name,
                                        ).push(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      } else {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: 'エリアの倉庫',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  for (final data in _data.warehouses!)
                    SizedBox(
                      width: size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
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
                                functionType: FunctionTypeEnum.home.name,
                              ).push(context);
                            },
                          ),
                        ),
                      ),
                    ),
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 倉庫検索タブへ遷移
                              controller.pushFunctionCard(
                                  FunctionType('home').branchIndex());
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // コメント・遅延登録画面へ遷移
                              controller.pushFunctionCard(
                                  FunctionType('userInput').branchIndex());
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 交通情報タブへ遷移
                              controller.pushFunctionCard(
                                  FunctionType('trafficInformation')
                                      .branchIndex());
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 設定タブへ遷移
                              controller.pushFunctionCard(
                                  FunctionType('setting').branchIndex());
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
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Consumer(builder: (context, ref, _) {
          final locationInfo = ref.watch(locationDataProvider);
          final location = locationInfo.getData();

          return Scaffold(
            backgroundColor: ColorName.scaffoldBackground,
            appBar: CustomAppBar(
              title: 'ホーム',
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.restart_alt_outlined,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //
                    // 現在時刻・現在地の表示部
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              SizedBox(
                                width: size.width * 0.5,
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                          top: 8.0,
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Icon(
                                                  Icons.location_on,
                                                  color:
                                                      ColorName.mainthemeColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 9,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 4,
                                                ),
                                                child: FutureBuilder<String>(
                                                    future: controller
                                                        .getCurrentAddress(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: CustomText(
                                                          text:
                                                              '${snapshot.data}',
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                          vertical: 7.0,
                                        ),
                                        child: FutureBuilder<String>(
                                          future: controller.getNearestRoadName(
                                            lat: location.lat,
                                            lng: location.lng,
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CustomText(
                                                text: '取得中',
                                                fontSize: 12,
                                              );
                                            }
                                            return CustomText(
                                              text: '${snapshot.data}',
                                              fontSize: 12,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.3,
                                height: 70,
                                color: const Color.fromARGB(255, 232, 231, 231),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Consumer(builder: (context, ref, _) {
                                      final clockInfo =
                                          ref.watch(clockDataProvider);
                                      final clock = clockInfo.getData();
                                      return FutureBuilder(
                                          future: controller.getNowTime(clock!),
                                          builder: (context, snapshot) {
                                            return CustomText(
                                              text: '${snapshot.data}',
                                              color: ColorName.splashMain,
                                            );
                                          });
                                    }),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          delayStateType:
                              _data.warehouseAreas![0].averageDelayState.name,
                          angle: GeolocatorService().calcBearingBetween(
                              warehouseLat: _data.warehouseAreas![0].latitude,
                              warehouseLng: _data.warehouseAreas![0].longitude),
                          distance: _data.warehouseAreas![0].distance,
                        ),
                      ],
                    ),
                    //
                    // エリアの天気情報の表示部
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            child: FutureBuilder<WeatherStateType?>(
                                future: controller.getWeatherState(
                                  lat: location.lat,
                                  lng: location.lng,
                                  isAfterOneHour: false,
                                ),
                                builder: (context, snapshot) {
                                  /// awaitしてる間とバグってnullの場合の処理
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.data == null) {
                                    return const CommonCard(
                                      cardColor: Colors.white,
                                      content: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return CommonCard(
                                    cardColor: snapshot.data!.color(),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: CustomText(
                                                text: '現在の天気',
                                                fontSize: 10,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CustomText(
                                                text: snapshot.data!.title(),
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(50.0),
                                                child: snapshot.data!.image(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
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
                            child: FutureBuilder<WeatherStateType?>(
                                future: controller.getWeatherState(
                                  lat: location.lat,
                                  lng: location.lng,
                                  isAfterOneHour: true,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.data == null) {
                                    return const CommonCard(
                                      cardColor: Colors.white,
                                      content: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return CommonCard(
                                    cardColor: snapshot.data!.color(),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: CustomText(
                                                text: '1時間後の天気',
                                                fontSize: 10,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CustomText(
                                                text: snapshot.data!.title(),
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
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
                                                padding:
                                                    const EdgeInsets.all(50.0),
                                                child: snapshot.data!.image(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<WarehouseInfo>?>(
                        future: controller.getFavoriteWarehouses(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<WarehouseInfo>?> snapshot) {
                          if (snapshot.hasData) {
                            List<WarehouseInfo> favoriteWarehousesList =
                                snapshot.data!;
                            return Column(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: 'お気に入りの倉庫',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                for (final data in favoriteWarehousesList)
                                  SizedBox(
                                    width: size.width * 0.95,
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: CommonCard(
                                        content: UserInputCell(
                                          warehouseAreaId: data.warehouseAreaId,
                                          warehouseName: data.warehouseName,
                                          warehouseId: data.warehouseId,

                                          /// 後ほど
                                          traficstateCountList:
                                              data.delayTimeDetails,
                                          delayStateType:
                                              data.averageDelayState.name,
                                          toWarehousePage: () {
                                            WarehouseDetailRoute(
                                              $extra: data,
                                              functionType:
                                                  FunctionTypeEnum.home.name,
                                            ).push(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          } else {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                        }),
                    //
                    // 各ページへの遷移ボタン
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: Strings.APP_FUNCTION,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 倉庫検索タブへ遷移
                              controller.pushFunctionCard(
                                  FunctionType(FunctionTypeEnum.search.name)
                                      .branchIndex());
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 交通情報タブへ遷移
                              controller.pushFunctionCard(FunctionType(
                                      FunctionTypeEnum.trafficInformation.name)
                                  .branchIndex());
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
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CommonCard(
                            onTap: () {
                              // 設定タブへ遷移
                              controller.pushFunctionCard(
                                  FunctionType(FunctionTypeEnum.setting.name)
                                      .branchIndex());
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

                    //
                    // 余白
                    const SizedBox(
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
