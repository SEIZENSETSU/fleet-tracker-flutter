import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Entity/Warehouse/search_info.dart';

/// WarehouseSearchInfoDataを監視するProvider
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

  bool? getIsInvading() {
    return _data?.isInvading;
  }

  /// setter
  void setData({
    WarehouseSearchInfo? data,
  }) {
    _data = data;
    notifyListeners();
  }

  /// 開発用エリア内切り替えsetter
  void setIsInvading(bool flag) {
    _data = WarehouseSearchInfo(
      isInvading: flag,
      favoriteWarehouses:
          WarehouseSearchInfoData().getData().favoriteWarehouses,
    );
    notifyListeners();
  }
}
