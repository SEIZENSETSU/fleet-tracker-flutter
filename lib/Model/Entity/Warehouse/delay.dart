import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';

class WarehouseDelay {
  final WarehouseDelayState delayState;
  final int answerCount;

  WarehouseDelay({
    required this.delayState,
    required this.answerCount,
  });

  factory WarehouseDelay.fromJson(Map<String, dynamic> json) {
    return WarehouseDelay(
      delayState: WarehouseDelayStateType(json['delay_state']).type,
      answerCount: json['answer_count'],
    );
  }
}
