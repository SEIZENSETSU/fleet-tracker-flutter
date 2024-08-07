import 'dart:convert';
import 'package:fleet_tracker/Service/Firebase/Authentication/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/comment.dart';
import '../../Log/log_service.dart';

class CommentService {
  FirebaseAuthenticationService get authService =>
      FirebaseAuthenticationService();
  late String baseUrl;
  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  CommentService() {
    baseUrl = dotenv.env['FLEET_TRACKER_API_BASEURL']!;
  }

  /// コメント一覧取得
  /// [warehouseId] 倉庫ID
  Future<List<Comment>?> getCommentList({
    required int warehouseId,
  }) async {
    Uri uri = Uri.https(
      baseUrl,
      '/comments',
      {'warehouse_id': '$warehouseId'},
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }

      List<dynamic> jsonResponse = json.decode(responseUtf8);
      List<Comment> commentList = [];
      for (dynamic commentData in jsonResponse) {
        Comment comment = Comment.fromJson(commentData);
        commentList.add(comment);
      }

      Log.echo('取得成功');
      return commentList;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// コメント登録
  /// [uid] ユーザーID
  /// [warehouseId] 倉庫ID
  /// [contents] コメント内容
  Future<int?> postComment({
    required String uid,
    required int warehouseId,
    required String contents,
  }) async {
    Uri uri = Uri.https(baseUrl, '/comment');
    Map<String, dynamic> comment = {
      'uid': uid,
      'warehouse_id': warehouseId,
      'contents': contents,
    };

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(comment),
      );

      if (response.statusCode != 201) {
        throw Exception('Post failed.');
      }

      Log.echo('コメントを投稿しました');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました$e');
      return null;
    }
  }

  /// コメント削除
  /// [commentId] コメントID
  Future<int?> deleteComment({required int commentId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/comment',
      {'comment_id': '$commentId'},
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.delete(
        uri,
        headers: headers,
      );
      if (response.statusCode != 204) {
        throw Exception('Delete failed.');
      }
      Log.echo('コメントを削除しました');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました');
      return null;
    }
  }

  /// コメント通報
  /// [commentId] コメントID
  /// [commentUserName] コメントした人の名前
  /// [reportUserName] 通報した人の名前
  /// [content] コメントの内容
  Future<int?> reportComment({
    required int commentId,
    required String commentUserUid,
    required String reportUserUid,
    required String content,
  }) async {
    try {
      final webhookUrl = dotenv.env['DISCORD_WEBHOOK_URL']!;
      final url = Uri.https('discord.com', webhookUrl);
      final headers = {'Content-Type': 'application/json'};

      final embed = {
        'title': '⚠ Fleet Tracker Report ⚠',
        'color': 5814783,
        'fields': [
          {'name': 'コメントID', 'value': commentId, 'inline': false},
          {'name': '投稿者', 'value': commentUserUid, 'inline': false},
          {'name': '通報者', 'value': reportUserUid, 'inline': false},
          {'name': '内容', 'value': content, 'inline': false}
        ],
        'footer': {
          'text': 'Fleet Tracker Report System',
        },
      };

      final body = jsonEncode({
        'username': 'Fleet Tracker',
        'avatar_url': '',
        'embeds': [embed],
      });

      http.Response response =
          await http.post(url, headers: headers, body: body);

      if (response.statusCode != 204) {
        throw Exception('Report failed.');
      }

      return response.statusCode;
    } catch (e) {
      return null;
    }
  }
}
