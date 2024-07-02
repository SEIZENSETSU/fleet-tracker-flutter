import 'package:fleet_tracker/Constants/Enum/traffic_detail_state_enum.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/detail.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';

class TrafficInformationDetailController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  Future<List<Map<String, dynamic>>?> getJamInfoList(roadId) async {
    late String type;
    List<Map<String, dynamic>> jamInfoList = [];
    List<Map<String, dynamic>> test = [
      {
        'direction': '函館方面',
        'place': '境古河IC→五霞IC',
        'type': '通行止',
        'supplementInfo': '工事',
      },
      {
        'direction': '上り',
        'place': '所沢IC付近',
        'type': '渋滞',
        'supplementInfo': '20km',
      }
    ];

    TrafficDetail? trafficDetail =
        await trafficInformationService.getTrafficDetail(roadId: 7);
    if (trafficDetail == null) {
      return null;
    }

    for (int i = 0; i < trafficDetail.data.issues.length; i++) {
      Map<String, dynamic> jamInfoMap = {};
      String? supplementInfo;
      String direction = trafficDetail.data.issues[i].direction;
      String place = trafficDetail.data.issues[i].place;
      TrafficDetailState originaltype = trafficDetail.data.issues[i].type;
      if (originaltype == TrafficDetailState.jam) {
        type = '渋滞';
      } else {
        type = '通行止・規制';
      }

      if (trafficDetail.data.issues[i].content != null) {
        supplementInfo = trafficDetail.data.issues[i].content;
      } else if (trafficDetail.data.issues[i].range != null) {
        supplementInfo = trafficDetail.data.issues[i].range;
      } else if (trafficDetail.data.issues[i].reason != null) {
        supplementInfo = trafficDetail.data.issues[i].reason;
      }
      jamInfoMap.addAll({
        'direction': direction,
        'place': place,
        'type': type,
        'supplementInfo': supplementInfo,
      });

      jamInfoList.addAll({jamInfoMap});
    }
    print(jamInfoList);
    return test;
  }
}
