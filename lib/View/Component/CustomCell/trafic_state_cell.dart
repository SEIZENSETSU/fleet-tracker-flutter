import 'package:fleet_tracker/View/Component/CustomCell/trafic_state_button_cell.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

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
                  padding: const EdgeInsets.only(left: 20),
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
              height: 50,
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
                            cellColor: Colors.green,
                            text: '平常',
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
                            cellColor: Colors.orange,
                            text: '一時停止\n 〜10分',
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
                            cellColor: Color.fromARGB(255, 196, 49, 39),
                            text: '〜30分',
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
                            cellColor: Colors.pinkAccent,
                            text: '30分以上',
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
                            cellColor: Colors.purple,
                            text: '入庫不可',
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
              height: 20,
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  child: Center(
                    child: CustomText(
                      text: '工場詳細ページへ→',
                      color: Colors.grey,
                      fontSize: 10,
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
