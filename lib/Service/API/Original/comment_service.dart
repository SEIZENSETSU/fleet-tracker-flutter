import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/comment.dart';
import '../../Log/log_service.dart';

abstract class BaseCommentService {
  late String baseUrl;
  late http.Response response;
  late Uri uri;
  final Map<String, String> headers = {'Content-type': 'application/json'};

  //コメント取得
  Future<List<Comment>?> getCommentList({required int warehouseId}) async {
    uri = Uri.https(baseUrl, '/comments', {'warehouse_id': warehouseId.toString()});

    try {
      response = await http.get(uri);
      if (response.statusCode != 200) {
        Log.echo('データを取得できませんでした');
        return null;
      }
      List<Comment> commentList = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (dynamic commentData in jsonResponse) {
        Comment comment = Comment(
          id: commentData['comment_id'],
          uid: commentData['uid'],
          warehouseId: commentData['warehouse_id'],
          contents: commentData['contents'],
          createdAt: commentData['created_at'],
        );
        commentList.add(comment);
      }
      Log.echo('取得成功');
      return commentList;
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました $e');
      return null;
    }
  }

  //コメント登録
  Future<void> postComment({required String uid, required int warehouseId, required String contents}) async {
    uri = Uri.https(baseUrl, '/comment');
    Map<String, dynamic> comment = {
      'uid': uid,
      'warehouse_id': warehouseId,
      'contents': contents,
    };

    try {
      response = await http.post(uri, headers: headers, body: jsonEncode(comment));

      if (response.statusCode != 201) {
        Log.echo('データを投稿することができませんでした。');
      } else {
        Log.echo('コメントを投稿しました');
      }
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました$e');
    }
  }

  //コメント削除
  Future<void> deleteComment({required int commentId}) async {
    uri = Uri.https(baseUrl, '/comment', {'comment_id': commentId.toString()});

    try {
      response = await http.delete(uri, headers: headers);
      if (response.statusCode != 204) {
        Log.echo('コメントを削除することができませんでした');
      } else {
        Log.echo('コメントを削除しました');
      }
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました');
    }
  }
}

//Mock用
class MockCommentService extends BaseCommentService {
  MockCommentService() {
    baseUrl = 'fleet-tracker-api-docs-tnvlhcq2ja-uc.a.run.app';
  }
}

//本番用
class ProdCommentService extends BaseCommentService {
  ProdCommentService() {
    baseUrl = 'HONBAN.com';
  }
}
