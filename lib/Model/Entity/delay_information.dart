import 'delay_time_detail.dart';

class DelayInformation {
  final int warehouseId;
  final String warehouseName;
  final List<DelayTimeDetail> delayTimeDetail;
  final String createdAt;
  final String updatedAt;

  DelayInformation({
    required this.warehouseId,
    required this.warehouseName,
    required this.delayTimeDetail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DelayInformation.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['delay_time_detail'] as List;
    List<DelayTimeDetail> delayTimeDetailList = list.map((i) => DelayTimeDetail.fromJson(i)).toList();

    return DelayInformation(
      warehouseId: json['warehouse_id'],
      warehouseName: json['warehouse_name'],
      delayTimeDetail: delayTimeDetailList,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
