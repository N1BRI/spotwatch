import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/main.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotMap extends StatefulWidget {
  const SpotMap({Key? key}) : super(key: key);

  @override
  State<SpotMap> createState() => _SpotMapState();
}

class _SpotMapState extends State<SpotMap> {
  final _geolocatorService = getIt<GeolocationService>();
  final _mapService = getIt<MapService>();
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onPositionChanged: (position, hasGesture) {
        },
        initialCenter:
            _geolocatorService.getUserLocation() ?? const LatLng(0, 0),
        initialZoom: 7.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.spotwatch.app',
        ),
        MarkerLayer(
          markers: _mapService.getNodeMarkers(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 70, 10),
          child: RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
