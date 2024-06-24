import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';

class WarehouseDelayInfo {
  final WarehouseDelayState delayState;
  final int answerCount;

  WarehouseDelayInfo({
    required this.delayState,
    required this.answerCount,
  });

  factory WarehouseDelayInfo.fromJson(Map<String, dynamic> json) {
    return WarehouseDelayInfo(
      delayState: WarehouseDelayStateType(json['delay_state']).type,
      answerCount: json['answer_count'],
    );
  }
}
