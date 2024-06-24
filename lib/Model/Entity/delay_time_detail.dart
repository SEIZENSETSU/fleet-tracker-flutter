import 'package:fleet_tracker/Constants/Enum/warehouse_delay_state_enum.dart';

class DelayTimeDetail {
  final WarehouseDelayState delayState;
  final int answerCount;

  DelayTimeDetail({
    required this.delayState,
    required this.answerCount,
  });

  factory DelayTimeDetail.fromJson(Map<String, dynamic> json) {
    return DelayTimeDetail(
      delayState: WarehouseDelayStateType(json['delay_state']).type,
      answerCount: json['answer_count'],
    );
  }
}
