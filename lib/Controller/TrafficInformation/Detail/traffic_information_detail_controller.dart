import 'package:fleet_tracker/Model/Entity/Traffic/detail.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/issue.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/sapa.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/sapa_info.dart';
import 'package:fleet_tracker/Service/API/TrafficInformation/traffic_information_service.dart';
import 'package:intl/intl.dart';

class TrafficInformationDetailController {
  TrafficInformationService trafficInformationService =
      TrafficInformationService();

  /// 道路の情報を取得する
  /// [roadId] 道路id
  Future<TrafficDetail?> getTrafficDetail(int roadId) async {
    TrafficDetail? trafficDetail =
        await trafficInformationService.getTrafficDetail(roadId: roadId);
    if (trafficDetail == null) {
      return null;
    }
    return trafficDetail;
  }

  /// 渋滞情報を取得する
  /// [roadId] 道路id
  Future<List<TrafficIssue>?> getTrafficIssueList(int roadId) async {
    TrafficDetail? trafficDetail =
        await trafficInformationService.getTrafficDetail(roadId: roadId);
    if (trafficDetail == null) {
      return null;
    }
    return trafficDetail.data.issues;
  }

  /// SAPA情報を取得する
  /// [roadId] 道路id
  Future<List<TrafficSapaInfo>?> getTrafficSapaInfoList(int roadId) async {
    TrafficSapa? trafficSapa =
        await trafficInformationService.getTrafficSapa(roadId: roadId);
    if (trafficSapa == null) {
      return null;
    }
    return trafficSapa.data.sapaInfoList;
  }

  /// 道路の状態を取得する
  /// [updateTimestamp] 情報の最終更新時刻
  String formatDateTime(DateTime updateTimestamp) {
    final formatter = DateFormat('hh:mm');
    return formatter.format(updateTimestamp).toString();
  }
}
