import 'package:fleet_tracker/Model/Entity/Traffic/about.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';

class TrafficInformationTopController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  Future<List<Map<String, dynamic>>?> getPrefectureInfoList() async {
    List<Map<String, dynamic>> prefectureInfoList = [];

    List<Map<String, dynamic>> test = [
      {
        'id': 1,
        'name': '東北',
        'totalIssues': 5,
        'roads': [
          {
            'roadId': 1,
            'name': '深川留萌道',
            'issues': true,
            'provideSapa': false,
          },
          {
            'roadId': 1,
            'name': '道央道',
            'issues': true,
            'provideSapa': false,
          },
        ]
      },
      {
        'id': 2,
        'name': '東北',
        'totalIssues': 4,
        'roads': [
          {
            'roadId': 7,
            'name': '青森道',
            'issues': true,
            'provideSapa': false,
          },
          {
            'roadId': 8,
            'name': '東北道',
            'issues': true,
            'provideSapa': true,
          },
        ]
      },
    ];

    TrafficAbout? trafficAbout =
        await trafficInformationService.getTrafficInformation();
    if (trafficAbout == null) {
      return null;
    }

    print('エリア数${trafficAbout.dataList.length}');

    for (int i = 0; i < trafficAbout.dataList.length; i++) {
      Map<String, dynamic> areaInfoMap = {};
      int areaId = trafficAbout.dataList[i].id;
      String areaName = trafficAbout.dataList[i].name;
      int areaIssues = trafficAbout.dataList[i].totalIssues;
      List<Map> roads = [];

      for (int j = 0; j < trafficAbout.dataList[i].roads.length; j++) {
        int roadId = trafficAbout.dataList[i].roads[j].id;
        String roadName = trafficAbout.dataList[i].roads[j].name;
        print('${roadId}${roadName}');
        int roadClosure = trafficAbout.dataList[i].roads[j].closure;
        int roadJam = trafficAbout.dataList[i].roads[j].jam;
        bool roadIssues = false;
        if (roadClosure + roadJam > 0) {
          roadIssues = true;
        }
        bool provideSapa = trafficAbout.dataList[i].roads[j].provideSapa;

        Map<String, dynamic> roadInfo = {};
        roadInfo.addAll({
          'roadId': roadId,
          'name': roadName,
          'issues': roadIssues,
          'provideSapa': provideSapa,
        });

        roads.addAll({roadInfo});
        areaInfoMap.addAll({
          'areaId': areaId,
          'name': areaName,
          'totalIssues': areaIssues,
          'roads': roads,
        });
      }
      prefectureInfoList.addAll({areaInfoMap});
    }

    print('👑最新版${prefectureInfoList}');
    return prefectureInfoList;
  }
}
