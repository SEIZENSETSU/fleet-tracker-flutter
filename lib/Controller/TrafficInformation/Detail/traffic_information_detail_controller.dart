import 'package:fleet_tracker/Constants/Enum/congestion_type_enum.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/detail.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/issue.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/sapa.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/sapa_info.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrafficInformationDetailController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  Future<TrafficDetail?> getRoadInfoMap(roadId) async {
    TrafficDetail? trafficDetail =
        await trafficInformationService.getTrafficDetail(roadId: 7);
    if (trafficDetail == null) {
      return null;
    }

    return trafficDetail;
  }

  Future<List<TrafficIssue>?> getJamInfoList(roadId) async {
    TrafficDetail? trafficDetail =
        await trafficInformationService.getTrafficDetail(roadId: 7);
    if (trafficDetail == null) {
      return null;
    }
    return trafficDetail.data.issues;
  }

  Future<List<TrafficSapaInfo>?> getSapaInfoList(roadId) async {
    TrafficSapa? trafficSapa =
        await trafficInformationService.getTrafficSapa(roadId: 8);
    if (trafficSapa == null) {
      return null;
    }
    return trafficSapa.data.sapaInfoList;
  }

  String formatDateTime(DateTime updateTimestamp) {
    final formatter = DateFormat('h:m');
    return formatter.format(updateTimestamp).toString();
  }
}
