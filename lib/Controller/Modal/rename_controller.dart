import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:flutter/material.dart';

import '../../Model/Entity/user.dart';
import '../../Service/API/Original/user_service.dart';

class RenameController {
  final TextEditingController textEditingController = TextEditingController();

  /// 変更ボタンの処理
  Future<void> changeButtonAction() async {
    User userData = UserData().getData();

    User setUser = User(uid: userData.uid, name: textEditingController.text);
    await UserService().updateUser(
      uid: setUser.uid,
      userName: setUser.name,
      fcmTokenId: userData.fcmTokenId,
    );

    User setterUser = User(uid: userData.uid, name: textEditingController.text);
    // シングルトンにセットする
    UserData().setData(data: setUser);
  }
}
