import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

class MapsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        key: Key('maps'),
        options: new MapOptions(
          center: LatLng(12, 121),
          zoom: 1.5,
          minZoom: 1.5,
          interactive: true,
          debug: true,
        ),
        layers: [
          TileLayerOptions(
            backgroundColor: Color(0xff191a1a),
            urlTemplate:
                'https://tile.jawg.io/dark/{z}/{x}/{y}.png?api-key=community',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
