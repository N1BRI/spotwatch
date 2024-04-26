import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/band_legend.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotMap extends StatefulWidget {
  const SpotMap({Key? key}) : super(key: key);

  @override
  State<SpotMap> createState() => _SpotMapState();
}

class _SpotMapState extends State<SpotMap> {
  final _mapService = getIt<MapService>();
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  bool _showBeacons = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
        return const Icon(Icons.cell_tower);
    }
  );
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onPositionChanged: (position, hasGesture) {
          _mapService.setPosition(position);
        },
        initialCenter:
            _mapService.getPosition().center ?? const LatLng(0.0, 0.0),
        initialZoom: _mapService.getPosition().zoom ?? 8.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.spotwatch.app',
        ),
        _showBeacons
            ? MarkerLayer(
                markers: _mapService.getNodeMarkers(),
              )
            : Container(),
        ListenableBuilder(
          listenable: _reverseBeaconService,
          builder: (context, child) {
            return MarkerLayer(
                markers:
                    _mapService.getSpotLayer(_reverseBeaconService.getSpots()));
          },
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
        Switch(thumbIcon: thumbIcon,
          value: _showBeacons,
          onChanged: (value) {
            setState(() {
              _showBeacons = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 12, 0,0),
          child: const BandLegend(),
        ),
      ],
    );
  }
}
