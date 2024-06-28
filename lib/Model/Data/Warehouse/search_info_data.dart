import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Entity/Warehouse/search_info.dart';

/// WarehouseSearchInfovider
final warehouseSearchInfoDataProvider =
    ChangeNotifierProvider((ref) => WarehouseSearchInfoData());

class WarehouseSearchInfoData extends ChangeNotifier {
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
    notifyListeners();
  }
}
