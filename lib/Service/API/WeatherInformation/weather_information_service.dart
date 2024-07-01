import 'dart:convert';
import 'package:fleet_tracker/Model/Entity/Weather/weatherList.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../../Log/log_service.dart';

class WeatherInformationService {
  late String baseUrl;
  late String apiKey;

  WeatherInformationService() {
    baseUrl = dotenv.env['WEATHER_INFORMATION_API_BASEURL']!;
    apiKey = dotenv.env['WEATHER_INFORMATION_API_KEY']!;
  }

  Future<WeatherList?> getWeatherInformaion({required String userLatitude, required String userLongitude}) async {
    Uri uri = Uri.https(
      baseUrl,
      'weather/V1/place',
      {'coordinates': '$userLongitude,$userLatitude', 'appid': apiKey},
    );

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }

      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(response.bodyBytes));
      final jsonString = xml2Json.toParker();

      Map<String, dynamic> jsonData = json.decode(jsonString);

      WeatherList weatherList = WeatherList.fromJson(jsonData);
      Log.echo('取得成功');
      return weatherList;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
