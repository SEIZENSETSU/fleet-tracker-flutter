import 'package:fleet_tracker/Model/Entity/user.dart';

class UserData {
  static final UserData _instance = UserData._internal();
  factory UserData() => _instance;
  UserData._internal();

  User? _data;

  /// getter
  User getData() {
    return _data!;
  }

  /// setter
  /// [data] ユーザー情報
  void setData({
    required User data,
  }) {
    _data = data;
  }
}
