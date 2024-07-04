import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';

class WarehouseDetailController {
  SharedPreferencesService prefs = SharedPreferencesService();
  bool enableAction = false;
  bool onLoad = false;
  outArea() {
    BottomNavigationBarController().goBranch(0);
  }

  /// 倉庫詳細ページ初期化処理
  /// [type]
  void initialize(String type) {
    FunctionTypeEnum typeEnum = FunctionType(type).type;
    switch (typeEnum) {
      case FunctionTypeEnum.home:
      case FunctionTypeEnum.userInput:
        enableAction = true;
      case FunctionTypeEnum.search:
        enableAction = false;
      default:
        enableAction = false;
    }
  }

  /// お気に入り登録のボタンが押された時の処理
  /// [warehouseId]
  Future<void> favoriteButtonAction({required int warehouseId}) async {
    if (!onLoad) {
      onLoad = true;
      // あるかチェック
      bool isFavorite = await favoriteListCheck(warehouseId: warehouseId);
      if (isFavorite) {
        // あったら削除
        await deleteFavorite(warehouseId: warehouseId);
        onLoad = false;
      } else {
        // なかったら追加
        await addFavoite(warehouseId: warehouseId);
        onLoad = false;
      }
    }
  }

  /// お気に入り倉庫をローカルに保存する
  /// [warehouseId]
  Future<void> addFavoite({required int warehouseId}) async {
    List<String>? favoriteIds = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);

    favoriteIds!.add(warehouseId.toString());
    await prefs.setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, favoriteIds);
    Log.toast('${warehouseId}をお気に入り倉庫に登録しました');
  }

  /// お気に入り倉庫をローカルから削除する
  /// [warehouseId]
  Future<void> deleteFavorite({required int warehouseId}) async {
    List<String>? favoriteList = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    // 配列から指定した工場を削除
    favoriteList!.removeWhere((element) => element == warehouseId.toString());
    // 削除した配列を保存
    await prefs.setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, favoriteList);

    Log.toast('${warehouseId}をお気に入り倉庫から削除しました');
  }

  /// 指定した倉庫がローカルに保存されているかチェック
  /// [warehouseId]
  Future<bool> favoriteListCheck({required int warehouseId}) async {
    List? favoriteList = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    if (favoriteList!.contains(warehouseId.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
