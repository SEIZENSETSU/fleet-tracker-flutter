import 'package:fleet_tracker/Controller/Component/comment_tile_controller.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Model/Data/user_data.dart';
import '../../../gen/colors.gen.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.userComment,
    required this.createAt,
    required this.userName,
    required this.userId,
    required this.commentId,
    this.setState,
  });

  final String userComment;
  final String createAt;
  final String userName;
  final String userId;
  final int commentId;
  final Function? setState;

  @override
  Widget build(BuildContext context) {
    CommentTileController controller = CommentTileController();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Container(
                    child: Assets.images.icons.userIcon.image(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border(bottom: BorderSide(color: Colors.black)),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: ColorName.mainthemeColor,
                              blurRadius: 0,
                              offset: Offset(3, 3),
                            )
                          ],
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: userId == UserData().getData().uid
                                          ? '自分'
                                          : '${userName}さん',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomText(
                                    text: userComment,
                                    fontSize: 14,
                                  ),
                                  userId == UserData().getData().uid
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () async {
                                              // コメント削除
                                              await controller.deleteComment(
                                                  commentId: commentId);
                                              if (setState != null) {
                                                setState!();
                                              }
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                color: ColorName.mainthemeColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () async {
                                              // ユーザーをブロックリストに追加
                                              await controller.addBlockUser(
                                                  uid: userId);
                                              if (setState != null) {
                                                setState!();
                                              }
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.block,
                                                  size: 14,
                                                ),
                                                CustomText(
                                                  text: 'ブロックする',
                                                  fontSize: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomText(
              text: createAt,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            // コメントを通報する。
            if (userId != UserData().getData().uid) {
              await controller.reportComment(
                  commentId: commentId,
                  commentUserUid: userId,
                  reportUserUid: UserData().getData().uid,
                  content: userComment);
            } else {
              Fluttertoast.showToast(msg: '自分のコメントは通報できません。');
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: 'コメントを通報する',
                  fontSize: 13,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.flag,
                  size: 13,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
