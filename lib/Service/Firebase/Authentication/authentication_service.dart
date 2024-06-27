import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';

class FirebaseAuthenticationService {
  late FirebaseAuth _instance;

  FirebaseAuthenticationService() {
    _instance = FirebaseAuth.instance;
  }

  /// 匿名ログインを行う
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _instance.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      Log.echo('signInAnonymously: $e', symbol: '🔒');
      return null;
    }
  }

  /// ユーザー情報を取得する
  User? getUser() {
    return _instance.currentUser;
  }

  /// UIDを取得する
  String? getUid() {
    return _instance.currentUser?.uid;
  }
}
