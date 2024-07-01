import 'package:fleet_tracker/Model/Entity/Traffic/about.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';

class TrafficInformationTopController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  getPrefectureNameMap() async {
    Map<String, List<String>> prefectureNameMap = {};
    List<int> totalIssues = [];
    TrafficAbout? trafficAbout =
        await trafficInformationService.getTrafficInformation();
    if (trafficAbout != null) {
      print('エリア数${trafficAbout.dataList.length}');

      for (int i = 0; i < trafficAbout.dataList.length; i++) {
        List<String> prefectureNameList = [];
        for (int j = 0; j < trafficAbout.dataList[i].roads.length; j++) {
          prefectureNameList.add(trafficAbout.dataList[i].roads[j].name);
          print(prefectureNameList);
        }
        prefectureNameMap
            .addAll({trafficAbout.dataList[i].name: prefectureNameList});
        totalIssues.add(trafficAbout.dataList[i].totalIssues);
      }

      print(prefectureNameMap);
      print(totalIssues);
    }
  }
}
