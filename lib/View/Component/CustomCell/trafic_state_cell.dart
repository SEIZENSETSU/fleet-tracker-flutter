import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/View/Component/CustomCell/trafic_state_button_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/assets.gen.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Service/Log/log_service.dart';

class TraficStateCell extends StatefulWidget {
  const TraficStateCell({
    super.key,
    required this.warehouseName,
    required this.traficstateCount,
  });

  final String warehouseName;
  final List traficstateCount;

  @override
  State<TraficStateCell> createState() => _TraficStateCellState();
}

class _TraficStateCellState extends State<TraficStateCell> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Log.echo('size: $size');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 330,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey,
        )),
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
                                image: Assets.images.component.factoryIcon
                                    .provider(),
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
                                text: widget.warehouseName,
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
                    color: ColorName.stateNormal.withAlpha(60),
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
                              color: ColorName.stateNormal,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: CustomText(
                            text: Strings.STATE_NORMAL,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorName.stateNormal.withAlpha(60),
                      border: Border(
                        top: BorderSide(
                          color: ColorName.stateNormal,
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
                                text: '現在、遅延に関する情報はありません。',
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
              height: 30,
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
                              color: ColorName.mianThemeColor.withAlpha(50),
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
                              child: TraficStateButtonCell(
                                cellColor: ColorName.stateNormal,
                                text: Strings.STATE_NORMAL,
                                onTap: () {
                                  Log.echo(
                                    'aaa',
                                  );
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
                              child: TraficStateButtonCell(
                                cellColor: ColorName.statePause,
                                text: Strings.STATE_PAUSE,
                                onTap: () {
                                  Log.echo(
                                    'aaa',
                                  );
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
                              child: TraficStateButtonCell(
                                cellColor: ColorName.stateHalfAnHour,
                                text: Strings.STATE_HALF_HOUR,
                                onTap: () {
                                  Log.echo(
                                    'aaa',
                                  );
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
                              child: TraficStateButtonCell(
                                cellColor: ColorName.stateAnHour,
                                text: Strings.STATE_AN_HOUR,
                                onTap: () {
                                  Log.echo(
                                    'aaa',
                                  );
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
                              child: TraficStateButtonCell(
                                cellColor: ColorName.stateImpossible,
                                text: Strings.STATE_IMPOSSIBLE,
                                onTap: () {
                                  Log.echo(
                                    'aaa',
                                  );
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
                              text: widget.traficstateCount[0].toString(),
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
                              text: widget.traficstateCount[1].toString(),
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
                              text: widget.traficstateCount[2].toString(),
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
                              text: widget.traficstateCount[3].toString(),
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
                              text: widget.traficstateCount[4].toString(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Log.echo('工場詳細ページへ遷移します');
                  },
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
          ],
        ),
      ),
    );
  }
}
