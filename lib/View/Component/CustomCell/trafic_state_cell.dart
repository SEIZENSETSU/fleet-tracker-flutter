import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/View/Component/CustomCell/trafic_state_button_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
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
        height: 250,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    height: 40,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: CustomText(
                        text: widget.warehouseName,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorName.mianThemeColor.withAlpha(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
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
                        Container(
                          width: 60,
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
                        Container(
                          width: 60,
                          height: 60,
                          child: TraficStateButtonCell(
                            cellColor: ColorName.stateHalfAnHour,
                            text: Strings.STATE_HALF_AN_HOUR,
                            onTap: () {
                              Log.echo(
                                'aaa',
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 60,
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
                        Container(
                          width: 60,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
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
                    Container(
                      width: 60,
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
                    Container(
                      width: 60,
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
                    Container(
                      width: 60,
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
                    Container(
                      width: 60,
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
