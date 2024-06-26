import 'delay_time_detail.dart';

class DelayInformation {
  final int warehouseId;
  final String warehouseName;
  final List<DelayTimeDetail> delayTimeDetail;

  DelayInformation({
    required this.warehouseId,
    required this.warehouseName,
    required this.delayTimeDetail,
  });

  factory DelayInformation.fromJson(Map<String, dynamic> json) {
    return DelayInformation(
      warehouseId: json['warehouse_id'],
      warehouseName: json['warehouse_name'],
      delayTimeDetail: json['delay_time_detail'].map<DelayTimeDetail>((x) => DelayTimeDetail.fromJson(x)).toList(),
    );
  }
}
