import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 現在の時間を監視するProvider
final clockDataProvider = ChangeNotifierProvider((ref) => ClockData());

class ClockData extends ChangeNotifier {
  static final ClockData _instance = ClockData._internal();
  factory ClockData() => _instance;
  ClockData._internal() {
    _updateData();
  }

  DateTime? _data;

  /// getter
  DateTime? getData() {
    return _data;
  }

  /// 現在の時間を更新する
  Future<void> _updateData() async {
    _data = DateTime.now();
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), _updateData);
  }
}
