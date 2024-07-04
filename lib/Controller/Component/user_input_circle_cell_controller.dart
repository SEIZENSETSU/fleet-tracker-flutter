import 'package:fleet_tracker/Service/API/Original/delay_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fleet_tracker/Service/Package/SharedPreferences/shared_preferences_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInputCircleCellController {
  SharedPreferencesService prefs = SharedPreferencesService();
  bool isAction = false;

  /// 遅延状況の登録
  /// [type]　 //遅延タイプ
  /// [id] 　　//倉庫ID
  Future<void> userInputCircleCellAction({
    required String type,
    required int id,
  }) async {
    isAction = true;
    if (isAction) {
      bool intervalFlag = await intervalCheck(warehouseId: id);
      if (intervalFlag) {
        try {
          int? response = await DelayService().postDelayInformation(
            warehouseId: id,
            delayState: type,
          );
          if (response == null) {
            Log.toast('エラーが発生しました');
            // エラーダイアログ表示
            isAction = false;
            return;
          }
          // 成功時の表示はなにかする？
          Log.toast('遅延情報を登録しました。');
          await prefs.setString(
              'post_delay_time_${id}', DateTime.now().toString());
          Fluttertoast.showToast(msg: '遅延情報を登録しました。');
          isAction = false;
        } catch (e) {
          Log.toast('エラーが発生しました $e');
          isAction = false;
          // エラーダイアログ表示
        }
      } else {
        Fluttertoast.showToast(msg: '前回の投稿から12時間経過していません。');
        Log.echo('前回の投稿から12時間経過していません', symbol: '😭');
      }
    }
  }

  /// 前回の登録から12時間空いているかチェック
  /// 12時間経過しているならtrue、経過していないならfales
  /// [warehouseId]
  Future<bool> intervalCheck({required int warehouseId}) async {
    String? posted = await prefs.getString('post_delay_time_${warehouseId}');
    if (posted == null) {
      return true;
    }
    final DateTime currentDateTime = DateTime.now();

    Duration interval = DateTime.parse(posted).difference(currentDateTime);

    Log.echo('経過時間は${interval.inHours}時間です');

    if (interval.inHours < 12) {
      return false;
    } else {
      return true;
    }
  }
}
