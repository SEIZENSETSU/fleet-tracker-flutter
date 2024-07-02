import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Component/user_input_circle_cell_controller.dart';
import 'package:fleet_tracker/Controller/UserInput/user_input_top_controller.dart';
import 'package:fleet_tracker/Model/Entity/delay_time_detail.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Dialog/error_dialog.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_circle_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../Constants/Enum/warehouse_delay_state_enum.dart';
import '../../../../Service/Log/log_service.dart';

class UserInputCell extends StatelessWidget {
  const UserInputCell({
    super.key,
    required this.warehouseName,
    required this.traficstateCountList,
    required this.delayStateType,
    required this.warehouseId,
    this.toWarehousePage,
    this.enableAction = true,
  });

  final String warehouseName;
  final int warehouseId;
  final List<DelayTimeDetail> traficstateCountList;
  final String delayStateType;
  final Function? toWarehousePage;
  final bool enableAction;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WarehouseDelayStateType stateType = WarehouseDelayStateType(delayStateType);
    Log.echo('size: $size');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 330,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    Assets.images.icons.factoryIcon.provider(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: const Color.fromARGB(255, 219, 217, 217),
                              child: CustomText(
                                text: warehouseName,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    color: stateType.color().withAlpha(60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: stateType.color(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.lerp(
                                    stateType.color(),
                                    Colors.white,
                                    0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: CustomText(
                            text: stateType.title(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: stateType.color().withAlpha(60),
                      border: Border(
                        top: BorderSide(
                          color: stateType.color(),
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Row(
                            children: [
                              CustomText(
                                fontSize: 10,
                                text: stateType.detail(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: enableAction ? '今の遅延状況は？ボタンを押して投稿！' : '現在の工場の遅延状態はこちら!',
              fontSize: 14,
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: ColorName.mainthemeColor.withAlpha(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              height: 60,
                              child: UserInputCircleCell(
                                cellColor: ColorName.stateNormal,
                                text: Strings.STATE_NORMAL_TITLE,
                                onTap: () async {
                                  if (!enableAction) {
                                    ErrorDialog().showErrorDialog(
                                        context: context,
                                        title: '倉庫検索から操作はできません',
                                        content: Assets
                                            .images.icons.errorDialogIcon
                                            .image(),
                                        detail: '該当のエリア内に移動してから再試行してください。',
                                        buttonText: '戻る');
                                  } else {
                                    //平常のボタン処理
                                    await UserInputCircleCellController()
                                        .userInputCircleCellAction(
                                      type: WarehouseDelayState.normal.name,
                                      id: warehouseId,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              height: 60,
                              child: UserInputCircleCell(
                                cellColor: ColorName.statePause,
                                text: Strings.STATE_PAUSE_TITLE,
                                onTap: () {
                                  if (!enableAction) {
                                    ErrorDialog().showErrorDialog(
                                        context: context,
                                        title: '倉庫検索から操作はできません',
                                        content: Assets
                                            .images.icons.errorDialogIcon
                                            .image(),
                                        detail: '該当のエリア内に移動してから再試行してください。',
                                        buttonText: '戻る');
                                  } else {
                                    // 一時停止ボタン処理
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              height: 60,
                              child: UserInputCircleCell(
                                cellColor: ColorName.stateHalfAnHour,
                                text: Strings.STATE_HALF_HOUR_TITLE,
                                onTap: () {
                                  if (!enableAction) {
                                    ErrorDialog().showErrorDialog(
                                        context: context,
                                        title: '倉庫検索から操作はできません',
                                        content: Assets
                                            .images.icons.errorDialogIcon
                                            .image(),
                                        detail: '該当のエリア内に移動してから再試行してください。',
                                        buttonText: '戻る');
                                  } else {
                                    // 30ふんボタン処理
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              height: 60,
                              child: UserInputCircleCell(
                                cellColor: ColorName.stateAnHour,
                                text: Strings.STATE_AN_HOUR_TITLE,
                                onTap: () {
                                  if (!enableAction) {
                                    ErrorDialog().showErrorDialog(
                                        context: context,
                                        title: '倉庫検索から操作はできません',
                                        content: Assets
                                            .images.icons.errorDialogIcon
                                            .image(),
                                        detail: '該当のエリア内に移動してから再試行してください。',
                                        buttonText: '戻る');
                                  } else {
                                    // 一時間ボタン処理
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              height: 60,
                              child: UserInputCircleCell(
                                cellColor: ColorName.stateImpossible,
                                text: Strings.STATE_IMPOSSIBLE_TITLE,
                                onTap: () {
                                  if (!enableAction) {
                                    ErrorDialog().showErrorDialog(
                                        context: context,
                                        title: '倉庫検索から操作はできません',
                                        content: Assets
                                            .images.icons.errorDialogIcon
                                            .image(),
                                        detail: '該当のエリア内に移動してから再試行してください。',
                                        buttonText: '戻る');
                                  } else {
                                    // 入庫不可ボタン処理
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: CustomText(
                              text: traficstateCountList[0]
                                  .answerCount
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: CustomText(
                              text: traficstateCountList[1]
                                  .answerCount
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: CustomText(
                              text: traficstateCountList[2]
                                  .answerCount
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: CustomText(
                              text: traficstateCountList[3]
                                  .answerCount
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: CustomText(
                              text: traficstateCountList[4]
                                  .answerCount
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            toWarehousePage != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: toWarehousePage != null
                            ? () {
                                Log.echo('工場詳細ページへ遷移します');
                                toWarehousePage!();
                              }
                            : () {},
                        child: Container(
                          width: 200,
                          height: 50,
                          child: const Center(
                            child: CustomText(
                              text: Strings.GO_WAREHOUSE_PAGE,
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
