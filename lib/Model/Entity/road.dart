import 'package:fleet_tracker/Constants/Enum/road_types_enum.dart';

class Road {
  final String highway;
  final RoadTypeEnumType type;
  final String name;

  Road({
    required this.highway,
    required this.type,
    required this.name,
  });
}
