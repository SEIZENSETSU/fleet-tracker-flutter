import 'dart:convert';

import 'package:fleet_tracker/Service/Firebase/Authentication/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Entity/delay_information.dart';
import '../../Log/log_service.dart';

class DelayService {
  FirebaseAuthenticationService get authService => FirebaseAuthenticationService();

  late String baseUrl;
  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  DelayService() {
    baseUrl = dotenv.env['FLEET_TRACKER_API_BASEURL']!;
  }

  /// 遅延情報取得
  /// [warehouseAreaId] 倉庫エリアID
  Future<List<DelayInformation>?> getDelayInformation({
    required int warehouseAreaId,
  }) async {
    Uri uri = Uri.https(
      baseUrl,
      '/delay',
      {'warehouse_area_id': '$warehouseAreaId'},
    );

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.get(
        uri,
        headers: headers,
      );
      final String responseUtf8 = utf8.decode(response.bodyBytes);
      if (response.statusCode != 200) {
        throw Exception('Fetch failed.');
      }
      List<dynamic> jsonResponse = json.decode(responseUtf8);

      List<DelayInformation> delayInformationList = [];
      for (dynamic delayInformationData in jsonResponse) {
        DelayInformation delayInformation = DelayInformation.fromJson(delayInformationData);
        delayInformationList.add(delayInformation);
      }

      Log.echo('取得成功');
      return delayInformationList;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }

  /// 遅延情報登録
  /// [warehouseId] 倉庫ID
  /// [delayState] 遅延状態
  Future<int?> postDelayInformation({
    required int warehouseId,
    required String delayState,
  }) async {
    Uri uri = Uri.https(baseUrl, '/delay');
    Map<String, dynamic> delayInformation = {
      'warehouse_id': warehouseId,
      'delay_state': delayState,
    };

    try {
      final String idToken = await authService.getIdToken() ?? '';
      headers['Authorization'] = 'Bearer $idToken';

      http.Response response = await http.post(
        uri,
        headers: headers,
        body: json.encode(delayInformation),
      );
      if (response.statusCode != 201) {
        throw Exception('Fetch failed.');
      }

      Log.echo('登録成功');
      return response.statusCode;
    } catch (e) {
      Log.echo('エラーが発生しました $e');
      return null;
    }
  }
}
