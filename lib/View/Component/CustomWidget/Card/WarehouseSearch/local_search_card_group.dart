import 'package:fleet_tracker/Route/router.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/cupertino.dart';

class LocalSearchCardGroup extends StatelessWidget {
  const LocalSearchCardGroup({
    super.key,
    required this.areaNameList,
    required this.areaImageUrlList,
  });

  final List<String> areaNameList;
  final List<String> areaImageUrlList;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (2 / 1),
      ),
      itemCount: areaNameList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            List<int> areaIdList = [];

            /// indexによってエリアIDを切り替える
            switch (index) {
              case 0:
                areaIdList.add(1);
              case 1:
                areaIdList.add(2);
              case 2:
                areaIdList.add(3);
              case 3:
                areaIdList.add(4);
              case 4:
                areaIdList.add(5);
              case 5:
                areaIdList.addAll([6, 7]);
              case 6:
                areaIdList.addAll([8, 9]);
            }

            WarehouseSearchResultRoute(
              areaId: areaIdList,
              areaName: areaNameList[index],
            ).push(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CommonCard(
              content: Align(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: deviceWidth * 0.15,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(areaImageUrlList[index]),
                        )),
                    CustomText(
                      text: areaNameList[index],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
