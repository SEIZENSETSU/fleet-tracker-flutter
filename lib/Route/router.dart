import 'package:fleet_tracker/Model/Entity/Warehouse/search_info.dart';
import 'package:fleet_tracker/Model/Entity/delay_time_detail.dart';
import 'package:fleet_tracker/View/Setting/UserBlockList/user_block_list_view.dart';
import 'package:fleet_tracker/tutorial_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../Model/Entity/Warehouse/info.dart';
import '../Model/Entity/Warehouse/warehouse.dart';
import '../View/Setting/HowToUse/how_to_use.dart';
import '../View/Setting/License/license_view.dart';
import '../View/Component/WarehouseDetail/warehouse_detail_view.dart';
import '../View/Home/home_view.dart';
import '../View/Setting/setting_top_view.dart';
import '../View/TrafficInformation/Detail/traffic_information_detail_view.dart';
import '../View/TrafficInformation/traffic_information_top_view.dart';
import '../View/UserInput/user_input_top_view.dart';
import '../View/WarehouseSearch/Result/warehouse_search_result_view.dart';
import '../View/WarehouseSearch/warehouse_search_top_view.dart';
import '../View/bottom_navigation_bar_view.dart';
import '../View/top_loading_view.dart';
import 'navigation_shell.dart';
import 'routes.dart';

part 'router.g.dart';

/// NavigatorKey
final rootNavigatorKey = GlobalKey<NavigatorState>();
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final warehouseSearchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'warehouseSearch');
final userInputNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'userInput');
final trafficInformationNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'trafficInformation');
final settingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'setting');

/// GoRouterProvider
final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    routes: $appRoutes,
  ),
);

//////////////////////////////  Initialize  //////////////////////////////
@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: Routes.home,
        ),
        TypedGoRoute<WarehouseDetailRoute>(
          path: Routes.warehouseDetail,
        ),
      ],
    ),
    TypedStatefulShellBranch<WarehouseSearchBranch>(
      routes: [
        TypedGoRoute<WarehouseSearchTopRoute>(
          path: Routes.warehouseSearch,
        ),
        TypedGoRoute<WarehouseSearchResultRoute>(
          path: Routes.warehouseSearchResult,
        ),
        TypedGoRoute<WarehouseDetailRoute>(
          path: Routes.warehouseDetail,
        ),
      ],
    ),
    TypedStatefulShellBranch<UserInputBranch>(
      routes: [
        TypedGoRoute<UserInputTopRoute>(
          path: Routes.userInput,
        ),
        TypedGoRoute<WarehouseDetailRoute>(
          path: Routes.warehouseDetail,
        ),
      ],
    ),
    TypedStatefulShellBranch<TrafficInformationBranch>(
      routes: [
        TypedGoRoute<TrafficInformationTopRoute>(
          path: Routes.trafficInformation,
        ),
        TypedGoRoute<TrafficInformationDetailRoute>(
          path: Routes.trafficInformationDetail,
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingBranch>(
      routes: [
        TypedGoRoute<SettingTopRoute>(
          path: Routes.setting,
        ),
        TypedGoRoute<HowToUseRoute>(
          path: Routes.howToUse,
        ),
        TypedGoRoute<LicenseRoute>(
          path: Routes.license,
        ),
        TypedGoRoute<UserBlockListRoute>(
          path: Routes.userBlockList,
        ),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    /// navigationShellをシングルトンで保持
    NavigationShell().set(navigationShell);

    // ignore: prefer_const_constructors
    return BottomNavigationBarView();
  }
}

//////////////////////////////  Branch  //////////////////////////////
/// home
class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = homeNavigatorKey;
}

/// warehouseSearch
class WarehouseSearchBranch extends StatefulShellBranchData {
  const WarehouseSearchBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      warehouseSearchNavigatorKey;
}

/// userInput
class UserInputBranch extends StatefulShellBranchData {
  const UserInputBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = userInputNavigatorKey;
}

/// trafficInformation
class TrafficInformationBranch extends StatefulShellBranchData {
  const TrafficInformationBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      trafficInformationNavigatorKey;
}

/// setting
class SettingBranch extends StatefulShellBranchData {
  const SettingBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = settingNavigatorKey;
}
//////////////////////////////  Initialize  //////////////////////////////

//////////////////////////////  Component  //////////////////////////////
class WarehouseDetailRoute extends GoRouteData {
  WarehouseDetailRoute({
    required this.$extra,
    required this.functionType,
  });
  final WarehouseInfo $extra;
  final String functionType;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WarehouseDetailView(
        warehouseInfo: $extra,
        functionType: functionType,
      );
}
//////////////////////////////  Component  //////////////////////////////

//////////////////////////////  Home  //////////////////////////////
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}
//////////////////////////////  Home  //////////////////////////////

//////////////////////////////  WarehouseSearch  //////////////////////////////
class WarehouseSearchTopRoute extends GoRouteData {
  const WarehouseSearchTopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WarehouseSearchTopView();
}

class WarehouseSearchResultRoute extends GoRouteData {
  const WarehouseSearchResultRoute({
    this.areaName,
    this.areaIds,
    this.keyword,
  });

  final String? areaName;
  final List<int>? areaIds;
  final String? keyword;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WarehouseSearchResultView(
        area: areaName,
        areaIds: areaIds,
        keyword: keyword,
      );
}
//////////////////////////////  WarehouseSearch  //////////////////////////////

//////////////////////////////  UserInput  //////////////////////////////
class UserInputTopRoute extends GoRouteData {
  const UserInputTopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UserInputTopView();
}
//////////////////////////////  UserInput  //////////////////////////////

//////////////////////////////  TrafficInformation  //////////////////////////////
class TrafficInformationTopRoute extends GoRouteData {
  const TrafficInformationTopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TrafficInformationTopView();
}

class TrafficInformationDetailRoute extends GoRouteData {
  const TrafficInformationDetailRoute(
      {required this.roadId, required this.provideSapa});
  final int roadId;
  final bool provideSapa;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TrafficInformationDetailView(
        roadId: roadId,
        provideSapa: provideSapa,
      );
}
//////////////////////////////  TrafficInformation  //////////////////////////////

//////////////////////////////  Setting  //////////////////////////////
class SettingTopRoute extends GoRouteData {
  const SettingTopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingTopView();
}

class HowToUseRoute extends GoRouteData {
  const HowToUseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HowToUseView();
}

class LicenseRoute extends GoRouteData {
  const LicenseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LicenseView();
}

class UserBlockListRoute extends GoRouteData {
  const UserBlockListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UserBlockListView();
}
//////////////////////////////  Setting  //////////////////////////////

//////////////////////////////  Root  //////////////////////////////
@TypedGoRoute<TopLoadingRoute>(
  path: Routes.root,
)
class TopLoadingRoute extends GoRouteData {
  TopLoadingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TopLoadingView();
}

@TypedGoRoute<TutorialRoute>(path: '/tutorial')
class TutorialRoute extends GoRouteData {
  TutorialRoute({this.showBackButton = false});

  final bool showBackButton;

  @override
  Widget build(BuildContext context, GoRouterState state) => TutorialPage(
        showBackButton: showBackButton,
      );
}
///////////////////////////  Root  //////////////////////////////