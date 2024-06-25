import '../../Entity/Warehouse/search_info.dart';

class WarehouseSearchInfoData {
  static final WarehouseSearchInfoData _instance =
      WarehouseSearchInfoData._internal();
  factory WarehouseSearchInfoData() => _instance;
  WarehouseSearchInfoData._internal();

  WarehouseSearchInfo? _data;

  /// getter
  WarehouseSearchInfo getData() {
    return _data!;
  }

  /// setter
  void setData({
    WarehouseSearchInfo? data,
  }) {
    _data = data;
  }
}
