import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Model/Entity/comment.dart';
import 'package:fleet_tracker/Service/API/Original/comment_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentTileController {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  /// コメントを削除するボタンの処理
  /// [commentId]
  Future<void> deleteComment({required int commentId}) async {
    int? response = await CommentService().deleteComment(commentId: commentId);
    if (response == null) {
      // コメント削除に失敗しました
      return;
    }

    // コメントを削除しました
    Fluttertoast.showToast(msg: 'コメントを削除しました。');
  }

  /// コメントを通報するをタップした時の処理
  /// [commentId]
  /// [commentUser]
  /// [reportUser]
  /// [content]
  Future<void> reportComment({
    required int commentId,
    required String commentUserUid,
    required String reportUserUid,
    required String content,
  }) async {
    int? response = await CommentService().reportComment(
      commentUserUid: commentUserUid,
      reportUserUid: reportUserUid,
      content: content,
      commentId: commentId,
    );

    if (response == null) {
      Fluttertoast.showToast(msg: '通報に失敗しました。');
      return;
    }

    // 通報しました。
    Fluttertoast.showToast(msg: '該当コメントを通報しました。');
  }

  /// ブロックユーザーをローカルに保存する
  /// [uid] //ブロックするユーザーのuid
  Future<void> addBlockUser({required String uid}) async {
    final blockUserList = await sharedPreferencesService
        .getStringList(SharedPreferencesKeysEnum.blockUserList.name);

    blockUserList!.add(uid);
    sharedPreferencesService.setStringList(
        SharedPreferencesKeysEnum.blockUserList.name, blockUserList);
  }
}
