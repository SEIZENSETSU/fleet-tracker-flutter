import 'package:fleet_tracker/Constants/Enum/warehouse_area_enum.dart';
import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/Controller/Component/user_input_circle_cell_controller.dart';
import 'package:fleet_tracker/Model/Entity/delay_information.dart';
import 'package:fleet_tracker/Model/Entity/delay_time_detail.dart';
import 'package:fleet_tracker/Service/API/Original/delay_service.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Dialog/custom_dialog.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/UserInput/user_input_circle_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/circular_progress_indicator_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/Enum/warehouse_delay_state_enum.dart';
import '../../../../Controller/Component/user_input_cell_controller.dart';
import '../../../../Service/Log/log_service.dart';

class UserInputCell extends StatefulWidget {
  const UserInputCell({
    super.key,
    required this.warehouseName,
    required this.traficstateCountList,
    required this.delayStateType,
    required this.warehouseId,
    required this.warehouseAreaId,
    this.toWarehousePage,
    this.enableAction = true,
  });

  final String warehouseName;
  final int warehouseId;
  final int warehouseAreaId;
  final List<DelayTimeDetail> traficstateCountList;
  final String delayStateType;
  final Function? toWarehousePage;
  final bool enableAction;

  @override
  State<UserInputCell> createState() => _UserInputCellState();
}

class _UserInputCellState extends State<UserInputCell> {
  UserInputCellController controller = UserInputCellController();
  bool onLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Log.echo('size: $size');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CustomText(
              text: WarehouseAreaType(widget.warehouseAreaId).name(),
              fontSize: 15,
            ),
          ),
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
                              image: Assets.images.icons.factoryIcon.provider(),
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
                          child: CustomText(
                            text: widget.warehouseName,
                            fontWeight: FontWeight.bold,
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
          FutureBuilder(
              future: controller.getAverageDelayState(
                  warehouseId: widget.warehouseId),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CirclarProgressIndicatorCell(height: 60);
                }

                if (snapshot.hasData) {
                  String? type = snapshot.data;
                  if (type == null) {
                    // エラー
                  }
                  WarehouseDelayStateType delayStateType =
                      WarehouseDelayStateType(type!);

                  return SizedBox(
                    height: 60,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          color: delayStateType.color().withAlpha(60),
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
                                    color: delayStateType.color(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.lerp(
                                          delayStateType.color(),
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
                                  text: delayStateType
                                      .title()
                                      .replaceAll("\n", " "),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: delayStateType.color().withAlpha(60),
                            border: Border(
                              top: BorderSide(
                                color: delayStateType.color(),
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Row(
                                children: [
                                  CustomText(
                                    fontSize: 10,
                                    text: delayStateType.detail(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const CirclarProgressIndicatorCell(height: 60);
                }
              }),
          const SizedBox(
            height: 15,
          ),
          CustomText(
            text:
                widget.enableAction ? '今の遅延状況は？ボタンを押して投稿！' : '現在の工場の遅延状態はこちら!',
            fontSize: 14,
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              FractionallySizedBox(
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
              FractionallySizedBox(
                widthFactor: 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: SizedBox(
                          height: 60,
                          child: UserInputCircleCell(
                            cellColor:
                                onLoading ? Colors.grey : ColorName.stateNormal,
                            text: Strings.STATE_NORMAL_TITLE,
                            onTap: () async {
                              if (!widget.enableAction) {
                                CustomDialog().showCustomDialog(
                                    context: context,
                                    title: 'エリア外から登録はできません',
                                    content: Assets.images.icons.errorDialogIcon
                                        .image(),
                                    detail: '該当のエリア内に移動してから再試行してください。',
                                    buttonText: '戻る');
                              } else {
                                //平常のボタン処理
                                if (!onLoading) {
                                  setState(() {
                                    onLoading = true;
                                  });
                                  await UserInputCircleCellController()
                                      .userInputCircleCellAction(
                                    type: WarehouseDelayState.normal.name,
                                    id: widget.warehouseId,
                                  );
                                  setState(() {
                                    onLoading = false;
                                  });
                                }
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
                        child: SizedBox(
                          height: 60,
                          child: UserInputCircleCell(
                            cellColor:
                                onLoading ? Colors.grey : ColorName.statePause,
                            text: Strings.STATE_PAUSE_TITLE,
                            onTap: () async {
                              if (!widget.enableAction) {
                                CustomDialog().showCustomDialog(
                                    context: context,
                                    title: 'エリア外から登録はできません',
                                    content: Assets.images.icons.errorDialogIcon
                                        .image(),
                                    detail: '該当のエリア内に移動してから再試行してください。',
                                    buttonText: '戻る');
                              } else {
                                //一時停止のボタン処理
                                if (!onLoading) {
                                  setState(() {
                                    onLoading = true;
                                  });
                                  await UserInputCircleCellController()
                                      .userInputCircleCellAction(
                                    type: WarehouseDelayState.pause.name,
                                    id: widget.warehouseId,
                                  );
                                  setState(() {
                                    onLoading = false;
                                  });
                                }
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
                        child: SizedBox(
                          height: 60,
                          child: UserInputCircleCell(
                            cellColor: onLoading
                                ? Colors.grey
                                : ColorName.stateHalfAnHour,
                            text: Strings.STATE_HALF_HOUR_TITLE,
                            onTap: () async {
                              if (!widget.enableAction) {
                                CustomDialog().showCustomDialog(
                                    context: context,
                                    title: 'エリア外から登録はできません',
                                    content: Assets.images.icons.errorDialogIcon
                                        .image(),
                                    detail: '該当のエリア内に移動してから再試行してください。',
                                    buttonText: '戻る');
                              } else {
                                //30分未満のボタン処理
                                if (!onLoading) {
                                  setState(() {
                                    onLoading = true;
                                  });
                                  await UserInputCircleCellController()
                                      .userInputCircleCellAction(
                                    type: WarehouseDelayState.halfHour.name,
                                    id: widget.warehouseId,
                                  );
                                  setState(() {
                                    onLoading = false;
                                  });
                                }
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
                        child: SizedBox(
                          height: 60,
                          child: UserInputCircleCell(
                            cellColor:
                                onLoading ? Colors.grey : ColorName.stateAnHour,
                            text: Strings.STATE_AN_HOUR_TITLE,
                            onTap: () async {
                              if (!widget.enableAction) {
                                CustomDialog().showCustomDialog(
                                    context: context,
                                    title: 'エリア外から登録はできません',
                                    content: Assets.images.icons.errorDialogIcon
                                        .image(),
                                    detail: '該当のエリア内に移動してから再試行してください。',
                                    buttonText: '戻る');
                              } else {
                                //1時間未満のボタン処理
                                if (!onLoading) {
                                  setState(() {
                                    onLoading = true;
                                  });
                                  await UserInputCircleCellController()
                                      .userInputCircleCellAction(
                                    type: WarehouseDelayState.anHour.name,
                                    id: widget.warehouseId,
                                  );
                                  setState(() {
                                    onLoading = false;
                                  });
                                }

                                Log.toast('message');
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
                        child: SizedBox(
                          height: 60,
                          child: UserInputCircleCell(
                            cellColor: onLoading
                                ? Colors.grey
                                : ColorName.stateImpossible,
                            text: Strings.STATE_IMPOSSIBLE_TITLE,
                            onTap: () async {
                              if (!widget.enableAction) {
                                CustomDialog().showCustomDialog(
                                    context: context,
                                    title: 'エリア外から登録はできません',
                                    content: Assets.images.icons.errorDialogIcon
                                        .image(),
                                    detail: '該当のエリア内に移動してから再試行してください。',
                                    buttonText: '戻る');
                              } else {
                                //入庫不可のボタン処理
                                if (!onLoading) {
                                  setState(() {
                                    onLoading = true;
                                  });
                                  await UserInputCircleCellController()
                                      .userInputCircleCellAction(
                                    type: WarehouseDelayState.impossible.name,
                                    id: widget.warehouseId,
                                  );
                                  setState(() {
                                    onLoading = false;
                                  });
                                }

                                Log.toast('message');
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: DelayService()
                  .getDelayInformation(warehouseAreaId: widget.warehouseAreaId),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CirclarProgressIndicatorCell(height: 30);
                }

                if (snapshot.hasData) {
                  final List<DelayInformation>? delayInformation =
                      snapshot.data;

                  if (delayInformation!.isEmpty) {
                    // エラー表示
                  }
                  // 現在の倉庫の遅延情報を抽出
                  final currrentWarehouse = delayInformation.firstWhere(
                      (element) => element.warehouseId == widget.warehouseId);

                  return FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0;
                            i < currrentWarehouse.delayTimeDetail.length;
                            i++)
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
                                    text: currrentWarehouse
                                        .delayTimeDetail[i].answerCount
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                } else {
                  return const CirclarProgressIndicatorCell(height: 30);
                }
              }),
          const SizedBox(
            height: 10,
          ),
          widget.toWarehousePage != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: widget.toWarehousePage != null
                          ? () {
                              Log.echo('工場詳細ページへ遷移します');
                              widget.toWarehousePage!();
                            }
                          : () {},
                      child: const SizedBox(
                        width: 200,
                        height: 50,
                        child: Center(
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
    );
  }
}
