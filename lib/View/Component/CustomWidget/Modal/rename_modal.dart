import 'package:fleet_tracker/View/Component/CustomWidget/Modal/custom_modal.dart';
import 'package:flutter/material.dart';

import '../../../../Controller/Modal/rename_controller.dart';
import '../../../../gen/colors.gen.dart';
import '../custom_button.dart';
import '../custom_text.dart';
import '../custom_textfield.dart';

class RenameModal {
  RenameController controller = RenameController();

  /// [userName] ユーザー名
  showReNameModal({
    required BuildContext context,
    required String userName,
    required Size size,
  }) {
    CustomModal().showModal(
      context: context,
      size: size,
      title: 'ユーザー名変更',
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'ユーザー名',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CustomTextfield(
                    hintText: userName,
                    backgroundcolor: Colors.white,
                    controller: controller.textEditingController,
                    isSerchIcon: false,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: CustomButton(
                    isFilledColor: true,
                    primaryColor: ColorName.mainthemeColor,
                    text: '変更',
                    onTap: () {
                      controller.changeButtonAction();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
