import 'package:fleet_tracker/View/Component/CustomWidget/TrafficInformation/traffic_information_tile_cell.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class TrafficInformationTopView extends StatefulWidget {
  const TrafficInformationTopView({super.key});

  @override
  State<TrafficInformationTopView> createState() =>
      _TrafficInformationStateTopViewState();
}

class _TrafficInformationStateTopViewState
    extends State<TrafficInformationTopView> {
  Map<String, List<String>> prefectureNameMap = {
    '北海道': [
      '深川留萌道',
      '道央道',
      '札樽道',
      '後志道',
      '道東道',
      '日高道',
    ],
    '東北': [
      '百石道路',
      '青森道',
      '東北道',
      '八戸道',
      '釜石道',
      '秋田道',
      '日本海東北道',
      '仙台北部道路',
      '仙台東部道路',
      '仙台南部道路',
      '東北中央道',
      '湯沢横手道路',
      '山形道',
      '常磐道',
      '磐越道',
    ],
    '北陸・信越': [
      '日本海東北道',
      '磐越道',
      '関越道',
      '上信越道',
      '北陸道',
      '東海北陸道',
      '安房峠道路',
      '長野道',
      '中央道',
    ],
    '関東': [
      '常磐道',
      '東北道',
      '北関東道',
      '関越道',
      '上信越道',
      '東水戸道路',
      '東北道',
      '圏央道',
      '中央道',
      '京葉道路',
      '東京外環道',
      '中部横断道',
      '東富士五湖道路',
      '第三京浜',
      '東関東道',
      '館山道',
      '富津館山道路',
      '東京湾アクアライン',
      '東名',
      '小田原厚木道路',
      '西湘バイパス',
      '横浜横須賀道路',
    ],
    '東海': [
      '長野道',
      '安房峠道路',
      '東海北陸道',
      '中央道',
      '中部横断道',
      '名神',
      '名二環',
      '新東名',
      '東名',
      '伊勢湾岸道',
      '東名阪道',
      '伊勢道',
      '紀勢道',
    ],
    '関西': [
      '名神',
      '新名神',
      '京都縦貫道',
      '京滋バイパス',
      '京奈和道',
      '舞鶴若狭道',
      '中国道',
      '播磨道',
      '三陽道',
      '第二京阪道路',
      '第二阪奈道路',
      '第二神明道路',
      '神戸淡路鳴門道',
      '近畿道',
      '西名阪道',
      '堺泉北道',
      '南阪奈道路',
      '関空橋',
      '阪和道',
      '湯浅御坊道路',
    ],
    '中国': [
      '山陰道',
      '松江道',
      '米子道',
      '中国道',
      '浜田道',
      '岡山道',
      '広島道',
      '瀬戸中央道',
      '西瀬戸道',
      '山陽道',
    ],
    '四国': [
      '瀬戸中央道',
      '西瀬戸道',
      '高松道',
      '神戸淡路鳴門道',
      '徳島道',
      '徳島南部道',
      '高知道',
      '松山道',
      '今治小松道',
    ],
    '九州・沖縄': [
      '九州道',
      '東九州道',
      '日出バイパス',
      '大分道',
      '長崎道',
      '長崎バイパス',
      '西九州道',
      '南九州道',
      '宮崎道',
      '沖縄道',
    ],
  };
  String imageUrl = 'https://www.c-ihighway.jp/smp/img/MAP/hokkaido.png';
  int count = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorName.mainthemeColor,
      ),
      body: ListView.builder(
        itemCount: prefectureNameMap.length,
        itemBuilder: (BuildContext context, int index) {
          String prefectureName = prefectureNameMap.keys.elementAt(index);
          List<String> prefecturalRoadList = prefectureNameMap[prefectureName]!;
          return TrafficInformationTileCell(
            imageUrl: imageUrl,
            count: count,
            prefectureName: prefectureName,
            prefecturalRoadList: prefecturalRoadList,
            index: index,
          );
        },
      ),
    );
  }
}
