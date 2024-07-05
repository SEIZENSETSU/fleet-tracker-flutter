import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../Card/common_card.dart';
import '../custom_text.dart';

class WarehuseDetailInfoModal {
  /// infoボタンをタップした時のモーダル表示
  /// [context] //BuildContext
  /// [size]    // Size
  showInfoModal({required BuildContext context, required Size size}) {
    CustomModal().showModal(
        context: context,
        size: size,
        title: '遅延情報登録について',
        content: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 0.9,
              child: const CustomText(text: '・遅延情報登録に関しての注意点'),
            ),
            SizedBox(
                width: size.width * 0.9,
                child: Assets.images.component.userInputInfo.image()),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 0.9,
              child: const CommonCard(
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '投稿のクールタイムについて',
                        color: ColorName.mainthemeColor,
                      ),
                      CustomText(
                        text:
                            '一度情報を投稿した工場に再度投稿する場合には、最後の投稿から12時間経過している必要があります。',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: size.width * 0.9,
              child: const CommonCard(
                content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '投稿可能なエリアについて',
                        color: ColorName.mainthemeColor,
                      ),
                      CustomText(
                        text: '遅延状況を投稿するにはその工場が所属しているエリア内に移動する必要があります。',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
