import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/user.dart';
import '../../Log/log_service.dart';

class UserService {
  late String baseUrl;
  final Map<String, String> headers = {'Content-type': 'application/json'};

  UserService() {
    baseUrl = dotenv.env['FLEET_TRACKER_API_BASEURL']!;
  }

  /// ユーザー情報取得
  /// [uid] ユーザーID
  Future<User?> getUserInfo({required String uid}) async {
    Uri uri = Uri.https(baseUrl, '/user', {'uid': uid});

    try {
      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw Exception('Get failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      User user = User.fromJson(jsonResponse);
      Log.echo('取得成功');
      return user;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// ユーザー情報登録
  /// [uid] ユーザーID
  /// [userName] ユーザー名
  /// [fcmTokenId] FCMトークンID
  Future<int?> registerUser({
    required String uid,
    required String userName,
    required String fcmTokenId,
  }) async {
    Uri uri = Uri.https(baseUrl, '/user');

    Map<String, dynamic> user = {
      'uid': uid,
      'user_name': userName,
      'fcm_token_id': fcmTokenId,
    };

    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(user),
      );

      if (response.statusCode != 201) {
        throw Exception('Register failed.');
      }
      Log.echo('ユーザー情報を登録しました');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// ユーザー情報更新
  /// [uid] ユーザーID
  /// [userName] ユーザー名
  /// [fcmTokenId] FCMトークンID
  Future<int?> updateUser({
    required uid,
    required userName,
    required fcmTokenId,
  }) async {
    Uri uri = Uri.https(baseUrl, '/user', {'uid': uid});

    Map<String, dynamic> user = {
      'user_name': userName,
      'fcm_token_id': fcmTokenId,
    };

    try {
      http.Response response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(user),
      );

      if (response.statusCode != 200) {
        throw Exception('Update failed.');
      }
      Log.echo('ユーザー情報を更新しました');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// ユーザー情報削除
  /// [uid] ユーザーID
  Future<int?> deleteUser({required uid}) async {
    Uri uri = Uri.https(baseUrl, '/user', {'uid': uid});

    try {
      http.Response response = await http.delete(
        uri,
        headers: headers,
      );

      if (response.statusCode != 204) {
        throw Exception('Delete failed.');
      }
      Log.echo('ユーザー情報を削除しました');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
