import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/comment.dart';
import '../../Log/log_service.dart';

abstract class BaseCommentService {
  late String baseUrl;
  late http.Response response;
  late Uri uri;
  final Map<String, String> headers = {'Content-type': 'application/json'};

  Future<List<Comment>?> getCommentList(int warehouse_id) async {
    uri = Uri.https(baseUrl, '/comments', {'warehouse_id': warehouse_id.toString()});

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
          comment_id: commentData['comment_id'],
          uid: commentData['uid'],
          warehouse_id: commentData['warehouse_id'],
          contents: commentData['contents'],
          created_at: commentData['created_at'],
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

  Future<void> postComment(String uid, int warehouse_id, String contents) async {
    uri = Uri.https(baseUrl, '/comment');

    String body = json.encode({'uid': uid, 'warehouse_id': warehouse_id, 'contents': contents});

    try {
      response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode != 201) {
        Log.echo('データを投稿することができませんでした。');
        return null;
      }
      Log.echo('コメントを投稿しました');
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました');
    }
  }

  Future<void> deleteComment(int comment_id) async {
    uri = Uri.https(baseUrl, '/comment', {'comment_id': comment_id.toString()});

    try {
      response = await http.delete(uri, headers: headers);
      if (response.statusCode != 204) {
        Log.echo('コメントを削除することができませんでした');
        return;
      }
      Log.echo('コメントを削除しました');
    } catch (e) {
      Log.echo('予期せぬエラーが発生しました');
    }
  }
}

class MockCommentService extends BaseCommentService {
  MockCommentService() {
    baseUrl = 'swagger-node-tnvlhcq2ja-uc.a.run.app';
  }

  @override
  Future<List<Comment>?> getCommentList(int warehouse_id) async {
    return await super.getCommentList(warehouse_id);
  }

  @override
  Future<void> postComment(String uid, int warehouse_id, String contents) async {
    return await super.postComment(uid, warehouse_id, contents);
  }

  @override
  Future<void> deleteComment(int comment_id) async {
    return await super.deleteComment(comment_id);
  }
}

class ProdCommentService extends BaseCommentService {
  ProdCommentService() {
    baseUrl = 'HONBAN.com';
  }

  @override
  Future<List<Comment>?> getCommentList(int warehouse_id) async {
    return await super.getCommentList(warehouse_id);
  }

  @override
  Future<void> postComment(String uid, int warehouse_id, String contents) async {
    return await super.postComment(uid, warehouse_id, contents);
  }

  @override
  Future<void> deleteComment(int comment_id) async {
    return await super.deleteComment(comment_id);
  }
}
