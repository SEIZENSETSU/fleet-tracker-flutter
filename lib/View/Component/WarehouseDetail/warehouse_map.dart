import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WarehouseMap extends StatelessWidget {
  WarehouseMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  double latitude;
  double longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            latitude,
            longitude,
          ),
          initialZoom: 10.0,
          maxZoom: 10.5,
          minZoom: 9.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                // ピンの位置を設定
                point: LatLng(
                  latitude,
                  longitude,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  // ここでピンのサイズを調整
                  size: 50,
                ),
                rotate: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
