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

  /// 交通情報取得
  Future<TrafficAbout?> getTrafficInformation() async {
    Uri uri = Uri.https(
      baseUrl,
      '/traffic/about',
    );

    try {
      http.Response response = await http.get(uri);
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(responseUtf8);

      TrafficAbout trafficAbout = TrafficAbout.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficAbout;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// 交通詳細情報取得
  /// [roadId] 道路ID
  Future<TrafficDetail?> getTrafficDetail({required int roadId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/traffic/detail',
      {'road_id': '$roadId'},
    );

    try {
      http.Response response = await http.get(uri);
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(responseUtf8);

      TrafficDetail trafficAbout = TrafficDetail.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficAbout;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// サービスエリアパーキングエリア情報取得
  /// [roadId] 道路ID
  Future<TrafficSapa?> getTrafficSapa({required int roadId}) async {
    Uri uri = Uri.https(
      baseUrl,
      '/sapa',
      {'road_id': '$roadId'},
    );

    try {
      http.Response response = await http.get(uri);
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      Map<String, dynamic> jsonResponse = json.decode(responseUtf8);

      TrafficSapa trafficSapa = TrafficSapa.fromJson(jsonResponse);

      Log.echo('取得成功');
      return trafficSapa;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
