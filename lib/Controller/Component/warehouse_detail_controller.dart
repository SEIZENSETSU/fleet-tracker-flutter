import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';

class WarehouseDetailController {
  bool enableAction = false;
  bool onLoad = false;
  outArea() {
    BottomNavigationBarController().goBranch(0);
  }

  initialize(String type) {
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

  Future<void> favoriteButtonAction(int id) async {
    if (!onLoad) {
      onLoad = true;
      // あるかチェック
      bool isFavorite = await favoriteListCheck(id);
      if (isFavorite) {
        // あったら削除
        await deleteFavorite(id);
        onLoad = false;
      } else {
        // なかったら追加
        await addFavoite(id);
        onLoad = false;
      }
    }
  }

  Future<void> addFavoite(int id) async {
    await SharedPreferencesService().setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, [id.toString()]);
    Log.toast('${id}をお気に入り倉庫に登録しました');
  }

  Future<void> deleteFavorite(int id) async {
    List<String>? favoriteList = await SharedPreferencesService()
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    // 配列から指定した工場を削除
    favoriteList!.removeWhere((element) => element == id.toString());
    // 削除した配列を保存
    await SharedPreferencesService().setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, favoriteList);

    Log.toast('${id}をお気に入り倉庫から削除しました');
  }

  Future<bool> favoriteListCheck(int id) async {
    List? favoriteList = await SharedPreferencesService()
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    // 配列に指定した工場が入っているかどうかチェック
    if (favoriteList!.contains(id.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
