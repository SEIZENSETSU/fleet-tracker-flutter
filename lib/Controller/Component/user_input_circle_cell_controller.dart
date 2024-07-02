import 'package:fleet_tracker/Service/API/Original/delay_service.dart';
import 'package:fleet_tracker/Service/Log/log_service.dart';

class UserInputCircleCellController {
  Future<void> userInputCircleCellAction({
    required String type,
    required int id,
  }) async {
    try {
      int? response = await DelayService().postDelayInformation(
        warehouseId: id,
        delayState: type,
      );
      if (response == null) {
        Log.toast('エラーが発生しました');
        // エラーダイアログ表示
        return;
      }
      // 成功時の表示はなにかする？
      Log.toast('登録しました');
    } catch (e) {
      Log.toast('エラーが発生しました $e');
      // エラーダイアログ表示
    }
  }
}
