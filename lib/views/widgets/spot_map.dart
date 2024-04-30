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
        },cameraConstraint:  CameraConstraint.contain(bounds: LatLngBounds(const LatLng(85.039642,-192.0), const LatLng(-85.029508, 190.0))) ,
        maxZoom: 12,
        onPointerDown: (event, point) {
          //print(point);
        },
        initialCenter:
            _mapService.getPosition().center ?? const LatLng(0.0, 0.0),
        initialZoom: _mapService.getPosition().zoom ?? 8.0,
      ),
      children: [
        TileLayer(retinaMode: RetinaMode.isHighDensity(context),
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
          userAgentPackageName: 'com.spotwatch.app',
        ),
        _mapService.getShowBeacons()
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
          value: _mapService.getShowBeacons(),
          onChanged: (value) {
            setState(() {
              _mapService.setShowBeacons(value);
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(70, 12, 0,0),
          child: BandLegend(),
        ),
      ],
    );
  }
}
