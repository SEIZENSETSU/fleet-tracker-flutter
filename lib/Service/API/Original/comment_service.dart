import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Entity/comment.dart';

class CommentService {
  Future<List<Comment>?> mockGetCommentList(int warehouse_id) async {
    Uri url = Uri.parse('https://api.letsbuildthatapp.com/youtube/home_feed');
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<Comment> commentList = [];
      List<dynamic> jsonResponse = json.decode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        Comment comment = Comment(
          comment_id: jsonResponse[i]['comment_id'],
          uid: jsonResponse[i]['uid'],
          warehouse_id: jsonResponse[i]['warehouse_id'],
          contents: jsonResponse[i]['contents'],
          created_at: jsonResponse[i]['created_at'],
        );
        commentList.add(comment);
      }
      return commentList;
    } else {
      return null;
    }
  }

  mockPostComment() {}
}
