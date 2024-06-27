import 'package:fleet_tracker/View/Component/CustomWidget/custom_modal.dart';
import 'package:flutter/widgets.dart';

class SettingTopController {
  showDebugModal({
    required BuildContext context,
  }) {
    CustomModal().showModal(context: context);
  }
}
