import 'package:fleet_tracker/Service/API/Original/comment_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentTileController {
  /// コメントを削除するボタンの処理
  /// [commentId]
  Future<void> deleteComment({required commentId}) async {
    int? response = await CommentService().deleteComment(commentId: commentId);
    if (response == null) {
      // コメント削除に失敗しました
      return;
    }

    // コメントを削除しました
    Fluttertoast.showToast(msg: 'コメントを削除しました。');
  }
}
