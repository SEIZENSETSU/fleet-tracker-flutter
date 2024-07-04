import 'package:fleet_tracker/Service/API/Original/delay_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInputCircleCellController {
  bool isAction = false;
  Future<void> userInputCircleCellAction({
    required String type,
    required int id,
  }) async {
    isAction = true;
    if (isAction) {
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
        Fluttertoast.showToast(msg: '遅延情報を登録しました。');
        isAction = false;
      } catch (e) {
        Log.toast('エラーが発生しました $e');
        isAction = false;
        // エラーダイアログ表示
      }
    }
  }
}
