import 'dart:convert';

import 'package:fleet_tracker/Model/Entity/Traffic/about.dart';
import 'package:fleet_tracker/Model/Entity/Traffic/detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Entity/Traffic/sapa.dart';
import '../../Log/log_service.dart';

class TrafficInformationService {
  late String baseUrl;

  TrafficInformationService() {
    baseUrl = dotenv.env['TRAFFIC_INFORMATION_API_BASEURL']!;
  }

  Future<TrafficAbout?> getTrafficInformation() async {
    Uri uri = Uri.https(
      baseUrl,
      '/traffic/about',
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      TrafficAbout trafficAbout = TrafficAbout.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficAbout;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  Future<TrafficDetail?> getTrafficDetail({required int roadId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/traffic/detail',
      {'road_id': '$roadId'},
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      TrafficDetail trafficAbout = TrafficDetail.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficAbout;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  Future<TrafficSapa?> getTrafficSapa({required int roadId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/sapa',
      {'road_id': '$roadId'},
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      TrafficSapa trafficSapa = TrafficSapa.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficSapa;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
