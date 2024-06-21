import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/colors.gen.dart';

class CommentTileCell extends StatelessWidget {
  const CommentTileCell({
    super.key,
    required this.userComment,
    required this.createAt,
    required this.userName,
  });

  final String userComment;
  final String createAt;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border(
          //   bottom: BorderSide(color: Colors.black),
          // ),
          ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Container(
                      child: Assets.images.component.userIcon.image(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border(bottom: BorderSide(color: Colors.black)),
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
                                  text: '${userName}さん',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              CustomText(
                                text: userComment,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomText(
                text: createAt,
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
