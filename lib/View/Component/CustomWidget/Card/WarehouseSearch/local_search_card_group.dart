import 'package:fleet_tracker/View/Component/CustomWidget/Card/common_card.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/cupertino.dart';

class LocalSearchCardGroup extends StatelessWidget {
  const LocalSearchCardGroup({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    List<String> localArea = [
      '北海道',
      '東北',
      '関東',
      '中部',
      '近畿',
      '中国・四国',
      '九州',
    ];
    List<String> areaImageUrl = [
      'https://www.c-ihighway.jp/smp/img/MAP/hokkaido.png',
      'https://www.c-ihighway.jp/smp/img/MAP/tohoku.png',
      'https://www.c-ihighway.jp/smp/img/MAP/kanto.png',
      'https://www.c-ihighway.jp/smp/img/MAP/hokuriku.png',
      'https://www.c-ihighway.jp/smp/img/MAP/kinki.png',
      'https://www.c-ihighway.jp/smp/img/MAP/chugoku.png',
      'https://www.c-ihighway.jp/smp/img/MAP/kyushu.png',
    ];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (2 / 1),
      ),
      itemCount: localArea.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
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
                          child: Image.network(areaImageUrl[index]),
                        )),
                    CustomText(
                      text: localArea[index],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
