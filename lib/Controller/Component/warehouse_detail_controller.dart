import 'package:fleet_tracker/Constants/Enum/function_type_enum.dart';
import 'package:fleet_tracker/Constants/Enum/shared_preferences_keys_enum.dart';
import 'package:fleet_tracker/Controller/bottom_navigation_bar_controller.dart';
import 'package:fleet_tracker/Model/Data/user_data.dart';
import 'package:fleet_tracker/Service/API/Original/comment_service.dart';
import 'package:fleet_tracker/Service/API/Original/user_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Model/Entity/comment.dart';
import '../../Model/Entity/user.dart';
import '../../View/Component/CustomWidget/custom_text.dart';

class WarehouseDetailController {
  SharedPreferencesService prefs = SharedPreferencesService();
  TextEditingController textEditingController = TextEditingController();
  bool enableAction = false;
  bool onLoad = false;
  outArea() {
    BottomNavigationBarController().goBranch(0);
  }

  /// 倉庫詳細ページ初期化処理
  /// [type]
  void initialize(String type) {
    FunctionTypeEnum typeEnum = FunctionType(type).type;
    switch (typeEnum) {
      case FunctionTypeEnum.home:
      case FunctionTypeEnum.userInput:
        enableAction = true;
      case FunctionTypeEnum.search:
        enableAction = false;
      default:
        enableAction = false;
    }
  }

  /// お気に入り登録のボタンが押された時の処理
  /// [warehouseId]
  Future<void> favoriteButtonAction({required int warehouseId}) async {
    if (!onLoad) {
      onLoad = true;
      // あるかチェック
      bool isFavorite = await favoriteListCheck(warehouseId: warehouseId);
      if (isFavorite) {
        // あったら削除
        await deleteFavorite(warehouseId: warehouseId);
        onLoad = false;
      } else {
        // なかったら追加
        await addFavorite(warehouseId: warehouseId);
        onLoad = false;
      }
    }
  }

  Future<bool> getIsFavorite({required int warehouseId}) async {
    // あるかチェック
    bool isFavorite = await favoriteListCheck(warehouseId: warehouseId);
    if (isFavorite) {
      // あったら削除
      return true;
    } else {
      // なかったら追加
      return false;
    }
  }

  /// お気に入り倉庫をローカルに保存する
  /// [warehouseId]
  Future<void> addFavorite({required int warehouseId}) async {
    List<String>? favoriteIds = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);

    favoriteIds!.add(warehouseId.toString());
    await prefs.setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, favoriteIds);
    Fluttertoast.showToast(msg: 'この工場をお気に入り登録しました。');
    Log.toast('${warehouseId}をお気に入り倉庫に登録しました');
  }

  /// お気に入り倉庫をローカルから削除する
  /// [warehouseId]
  Future<void> deleteFavorite({required int warehouseId}) async {
    List<String>? favoriteList = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    // 配列から指定した工場を削除
    favoriteList!.removeWhere((element) => element == warehouseId.toString());
    // 削除した配列を保存
    await prefs.setStringList(
        SharedPreferencesKeysEnum.favoriteWarehouseList.name, favoriteList);
    Fluttertoast.showToast(msg: 'お気に入り登録を解除しました。');
    Log.toast('${warehouseId}をお気に入り倉庫から削除しました');
  }

  /// 指定した倉庫がローカルに保存されているかチェック
  /// [warehouseId]
  Future<bool> favoriteListCheck({required int warehouseId}) async {
    List? favoriteList = await prefs
        .getStringList(SharedPreferencesKeysEnum.favoriteWarehouseList.name);
    if (favoriteList!.contains(warehouseId.toString())) {
      return true;
    } else {
      return false;
    }
  }

  /// コメントを投稿する処理
  /// [content]
  /// [warehouseId]
  Future<void> postComment(
      {required String content, required int warehouseId}) async {
    if (content == '') {
      Fluttertoast.showToast(msg: 'コメントを入力してください。');
      return;
    }
    int? response = await CommentService().postComment(
      uid: UserData().getData().uid,
      warehouseId: warehouseId,
      contents: content,
    );

    if (response == null) {
      Fluttertoast.showToast(msg: 'コメントを投稿できませんでした。');
      textEditingController.text = '';
      return;
    }

    Fluttertoast.showToast(msg: 'コメントを投稿しました。');
    textEditingController.text = '';
    Log.echo('コメントを投稿しました');
  }

  /// コメント表示部に必要な情報を取得
  /// [warehouseId]
  Future<List<Map<String, dynamic>>?> getCommentList(
      {required warehouseId}) async {
    List<Map<String, dynamic>> commentTileInfo = [];
    List<Comment>? commentList =
        await CommentService().getCommentList(warehouseId: warehouseId);
    if (commentList == null) {
      // 取得に失敗
      return null;
    }
    List<String> userName = [];
    // コメントリストからブロックしたユーザーを排除
    List<String>? blockedUserList =
        await prefs.getStringList(SharedPreferencesKeysEnum.blockUserList.name);
    print(blockedUserList);
    List<Comment> filteredComments = commentList.where((comment) {
      return !blockedUserList!.contains(comment.uid);
    }).toList();

    print(filteredComments);

    for (int i = 0; i < filteredComments.length; i++) {
      User? user =
          await UserService().getUserInfo(uid: filteredComments[i].uid);
      if (user == null) {
        userName.add('名無し');
      } else {
        print(user.name);
        userName.add(user.name);
      }
    }
    commentTileInfo = [
      for (int i = 0; i < filteredComments.length; i++)
        {
          'name': userName[i],
          'id': filteredComments[i].uid,
          'comment': filteredComments[i].contents,
          'create_at': filteredComments[i].createdAt,
          'comment_id': filteredComments[i].id,
        }
    ];

    print(commentTileInfo);

    return commentTileInfo;
  }
}
