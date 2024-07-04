import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:flutter/material.dart';

import '../../Model/Entity/user.dart';
import '../../Service/API/Original/user_service.dart';

class RenameController {
  final TextEditingController textEditingController = TextEditingController();

  /// 変更ボタンの処理
  void changeButtonAction() {
    User userData = UserData().getData();
    UserService().updateUser(
      uid: userData.uid,
      userName: textEditingController.text,
      fcmTokenId: userData.fcmTokenId,
    );
  }
}
