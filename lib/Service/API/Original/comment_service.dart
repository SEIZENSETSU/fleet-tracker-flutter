import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/comment.dart';
import '../../Log/log_service.dart';

class CommentService {
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
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }

      List<dynamic> jsonResponse = json.decode(response.body);
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
}
