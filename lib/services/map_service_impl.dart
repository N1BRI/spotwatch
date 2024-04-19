import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';

class MapServiceImpl extends ChangeNotifier
    with Loadable
    implements MapService {
  final GeolocationService _geolocationService;
  final ReverseBeaconNodeService _reverseBeaconNodeService;
 // final MapController _mapController = MapController();
  double _zoom = 8.0;
  LatLng _currentPosition = const LatLng(37.234332396, -115.80666344);

  MapServiceImpl(
      {required ReverseBeaconNodeService reverseBeaconNodeService,
      required GeolocationService geolocationService})
      : _geolocationService = geolocationService,
        _reverseBeaconNodeService = reverseBeaconNodeService {
    var location = _geolocationService.getUserLocation();
    _currentPosition = location ?? _currentPosition;
  }

  @override
  void addSpotMarker(Spot spot) {
    // TODO: implement addSpotMarker
  }

  @override
  MapController getMapController() {
    // TODO: implement getMapController
    throw UnimplementedError();
  }

  @override
  void removeSpotMarker(Spot spot) {
    // TODO: implement removeSpotMarker
  }

  @override
  List<Marker> getNodeMarkers() {
    return _reverseBeaconNodeService
        .getBeacons()
        .map((b) => Marker(
            point: b.latLng,
            width: 15,
            height: 15,
            child: const Icon(Icons.settings_input_antenna_outlined, size: 16, color: Color(0xff2b87ff))))
        .toList();
  }
}
