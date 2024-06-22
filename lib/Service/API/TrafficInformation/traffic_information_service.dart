import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Log/log_service.dart';

class TrafficInformationService {
  late String baseUrl;

  TrafficInformationService() {
    baseUrl = dotenv.env['TRAFFIC_INFORMATION_API_BASEURL']!;
  }

  Future<Map<String, dynamic>> getTrafficInformation({
    required String areaId,
  }) async {
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

      Log.echo('取得成功');
      Log.echo(jsonResponse['traffic_information']);
      return jsonResponse;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return {};
    }
  }
}
