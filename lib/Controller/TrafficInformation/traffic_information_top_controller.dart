import 'package:fleet_tracker/Model/Entity/Traffic/about.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/area.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';

class TrafficInformationTopController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  Future<List<TrafficArea>?> getTraffiiAreatList() async {
    TrafficAbout? trafficAbout =
        await trafficInformationService.getTrafficInformation();
    if (trafficAbout == null) {
      return null;
    }
    return trafficAbout.dataList;
  }
}
