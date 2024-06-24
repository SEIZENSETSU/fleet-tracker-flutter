import 'package:fleet_tracker/Model/Entity/location.dart';

class LocationData {
  static final LocationData _instance = LocationData._internal();
  factory LocationData() => _instance;
  LocationData._internal();

  Location? _data;

  /// getter
  Location getData() {
    if (_data == null) {
      throw Exception('LocationData is null');
    }
    return _data!;
  }

  /// setter
  void setData(Location data) {
    _data = data;
  }
}
