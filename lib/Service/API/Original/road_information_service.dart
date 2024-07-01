import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:fleet_tracker/Constants/Enum/road_types_enum.dart';
import 'package:fleet_tracker/Model/Entity/road.dart';

class RoadInformationService {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // 地球の半径 (km)

    double dLat = (lat2 - lat1) * pi / 180;
    double dLon = (lon2 - lon1) * pi / 180;
    double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // 距離をメートルで返す
    return R * c * 1000;
  }

  Future<Road?> getNearestRoad(double lat, double lon) async {
    const double radius = 8; // 半径（メートル）
    const String overpassUrl = 'http://overpass-api.de/api/interpreter';

    String overpassQuery = '''
    [out:json];
    (
      way["highway"]
        (around:$radius,$lat,$lon);
    );
    out body;
    >;
    out skel;
  ''';

    final response = await http.get(
      Uri.parse(overpassUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }

    final data = json.decode(response.body);
    final elements = data['elements'];
    final nodes = elements.where((element) => element['type'] == 'node').toList();
    final Map<int, dynamic> nodeMap = {};

    for (var node in nodes) {
      nodeMap[node['id']] = node;
    }

    Road? nearestRoad;
    double minDistance = double.infinity;

    final roads = elements.where((element) => element['type'] == 'way').toList();

    for (var road in roads) {
      for (var nodeId in road['nodes']) {
        final node = nodeMap[nodeId];
        if (node != null) {
          final double nodeLat = node['lat'];
          final double nodeLon = node['lon'];
          final double distance = calculateDistance(lat, lon, nodeLat, nodeLon);
          if (distance < minDistance) {
            minDistance = distance;
            nearestRoad = Road(
              highway: road['tags']['highway'],
              type: RoadTypeEnumType(road['tags']['highway']),
              name: road['tags']['name'],
            );
          }
        }
      }
    }

    return nearestRoad;
  }
}
