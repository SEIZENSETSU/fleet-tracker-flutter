import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';

import 'japan_map_card.dart';

class JapanMapDefomed extends StatelessWidget {
  const JapanMapDefomed({
    super.key,
    required this.setState,
  });

  final Function setState;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      color: ColorName.japanMapDeformedBackground,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '北海道',
                        areaId: [1],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '東北',
                        areaId: [2],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '中国・四国',
                        areaId: [5, 6],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '近畿',
                        areaId: [4],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '中部',
                        areaId: [3],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '関東',
                        areaId: [9],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: JapanMapCard(
                        name: '九州',
                        areaId: [7, 8],
                        setState: () {
                          setState();
                        },
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
