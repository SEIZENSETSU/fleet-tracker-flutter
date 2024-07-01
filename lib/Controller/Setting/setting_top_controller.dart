import 'package:flutter/widgets.dart';
import '../../View/Component/CustomWidget/Modal/debug_modal.dart';

class SettingTopController {
  showDebugModal({
    required BuildContext context,
    required Size size,
  }) {
    DebugModal().showModal(
      context: context,
      size: size,
    );
  }
}
