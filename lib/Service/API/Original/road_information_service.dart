import 'dart:convert';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RoadInformationService {
  late String baseUrl;

  RoadInformationService() {
    baseUrl = dotenv.env['ROAD_INFORMATION_API_BASEURL']!;
  }

  /// 最寄りの高速道路名取得
  /// [latitude] 緯度
  /// [longitude] 経度
  Future<String?> getNearestRoadName({
    required double latitude,
    required double longitude,
  }) async {
    /// 検索範囲
    const int radius = 100;

    /// 検索条件のクエリ
    final String query = '''
      [out:json];
      (
        way["highway" = "motorway"]
          (around:$radius,$latitude,$longitude);
      );
      out body;
      >;
      out skel;
    ''';

    try {
      Uri uri = Uri.https(
        baseUrl,
        '/api/interpreter',
        {'data': query},
      );

      http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }

      Map<String, dynamic> jsonResponse = json.decode(
        utf8.decode(response.bodyBytes),
      );

      /// 付近100m以内に高速道路が見つからなかった場合、
      /// 走っていないと判定してnullを返す
      if (jsonResponse['elements'].isEmpty) {
        Log.echo('今は高速道路を走っていません');
        return null;
      }

      String nearestRoadName = jsonResponse['elements'][0]['tags']['name'];
      Log.echo('取得成功');
      Log.echo(nearestRoadName);
      return nearestRoadName;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
