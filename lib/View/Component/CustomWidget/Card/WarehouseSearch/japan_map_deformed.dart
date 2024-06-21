import 'package:flutter/cupertino.dart';

import 'japan_map_card.dart';

class JapanMapDefomed extends StatelessWidget {
  const JapanMapDefomed({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5,
      color: Color.fromARGB(255, 160, 212, 255),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
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
                    child: Container(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: JapanMapCard(
                            name: '北海道',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
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
                    flex: 1,
                    child: Container(
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: JapanMapCard(
                            name: '東北',
                          ),
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
          ),
          Expanded(
            flex: 1,
            child: Container(
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
          ),
          Expanded(
            flex: 1,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
