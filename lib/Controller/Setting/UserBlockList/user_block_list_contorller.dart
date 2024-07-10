import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Service/API/Original/user_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';

import '../../../Model/Entity/user.dart';

class UserBlockListController {
  SharedPreferencesService prefs = SharedPreferencesService();
  UserService get _userService => UserService();

  /// SharedPreferencesに保存されているブロックユーザーリストを取得
  Future<List<User>> getBlockList() async {
    List<String> prefsBlockList = await prefs
            .getStringList(SharedPreferencesKeysEnum.blockUserList.name) ??
        [];
    List<User> blockList = [];
    for (String uid in prefsBlockList) {
      User? user = await _userService.getUserInfo(uid: uid);
      if (user != null) {
        blockList.add(user);
      }
    }
    return blockList;
  }

  /// ブロックユーザーリストを保存
  Future<void> setBlockList(List<String> blockList) async {
    await prefs.setStringList(
        SharedPreferencesKeysEnum.blockUserList.name, blockList);
  }

  Future<void> removeBlockList(String uid) async {
    List<String> prefsBlockList = await prefs
            .getStringList(SharedPreferencesKeysEnum.blockUserList.name) ??
        [];
    prefsBlockList.remove(uid);
    await setBlockList(prefsBlockList);
  }
}
