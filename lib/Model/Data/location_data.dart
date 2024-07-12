import 'package:fleet_tracker/Model/Entity/location.dart';
import 'package:fleet_tracker/Service/Package/Location/geolocator_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// LocationDataを監視するProvider
final locationDataProvider = ChangeNotifierProvider((ref) => LocationData());

class LocationData extends ChangeNotifier {
  static final LocationData _instance = LocationData._internal();
  factory LocationData() => _instance;
  LocationData._internal();

  GeolocatorService get locationPackageService => GeolocatorService();

  Location? _data;

  /// getter
  Location getData() {
    return _data ??
        Location(
          lat: 43.0,
          lng: 141.0,
          time: DateTime.now().subtract(
            const Duration(days: 1),
          ),
        );
  }

  /// setter
  /// force = trueの場合のみawaitが必要
  /// [data] 位置情報
  /// [force] 強制的に位置情報をSetするかどうか
  Future<void> setData({
    Location? data,
    bool force = false,
  }) async {
    /// Locationパッケージを利用して強制的に位置情報をSetする
    if (force || data == null || _data == null) {
      data = await locationPackageService.getLocationAsCustom();
    }
    _data = data;
    notifyListeners();
  }
}
