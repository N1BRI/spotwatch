import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gridlocator/gridlocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/core/color_helpers.dart';
import 'package:spotwatch/core/extensions/map_extensions.dart';

class MapServiceImpl extends ChangeNotifier
    with Loadable
    implements MapService {
  final GeolocationService _geolocationService;
  final ReverseBeaconService _reverseBeaconService;
  final ReverseBeaconNodeService _reverseBeaconNodeService;
  // final MapController _mapController = MapController();
  MapPosition _mapPosition =
      const MapPosition(zoom: 8.0, center: LatLng(37.234332396, -115.80666344));
  bool _showBeacons = true;

  MapServiceImpl(
      {required ReverseBeaconService reverseBeaconService,
      required ReverseBeaconNodeService reverseBeaconNodeService,
      required GeolocationService geolocationService})
      : _geolocationService = geolocationService,
        _reverseBeaconNodeService = reverseBeaconNodeService,
        _reverseBeaconService = reverseBeaconService {
    var location = _geolocationService.getUserLocation();
    _mapPosition = _mapPosition.copyWith(center: location);
  }

  @override
  MapController getMapController() {
    // TODO: implement getMapController
    throw UnimplementedError();
  }

  @override
  List<Marker> getNodeMarkers() {
    return _reverseBeaconNodeService
        .getBeacons()
        .map((b) => Marker(
            point: b.latLng,
            width: 15,
            height: 15,
            child: const Icon(Icons.my_location,
                size: 16, color: Color(0xff2b87ff))))
        .toList();
  }

  @override
  MapPosition getPosition() {
    return _mapPosition;
  }

  @override
  void setPosition(MapPosition position) {
    _mapPosition = position;
  }

  @override
  double? getSpotDistanceMeters(Spot spot) {
    double? distance;
    if (spot.spottedCall ==
        _reverseBeaconService.getCallsign()?.toUpperCase()) {
      var userLatLng = _geolocationService.getUserLocation();
      var skimmerLatLng =
          _reverseBeaconNodeService.getLatLngByCallsign(spot.skimmerCall);
      if (userLatLng != null && skimmerLatLng != null) {
        distance = Geolocator.distanceBetween(
            userLatLng.latitude,
            userLatLng.longitude,
            skimmerLatLng.latitude,
            skimmerLatLng.longitude);
      }
    } else if (spot.mode == Mode.ft4 || spot.mode == Mode.ft8) {
      var gridSquare = (spot as DigiSpot).gridSquare;
      var skimmerLatLng =
          _reverseBeaconNodeService.getLatLngByCallsign(spot.skimmerCall);
      if (gridSquare != null && gridSquare != 'N/A' && skimmerLatLng != null) {
        if(gridSquare.length == 4){
          gridSquare = '${gridSquare}aa';
        }
        var digiSpotLoc = Gridlocator.decode(gridSquare);
        var digiSpotLatLng =
            LatLng(digiSpotLoc.latitude, digiSpotLoc.longitude);
        distance = Geolocator.distanceBetween(
            digiSpotLatLng.latitude,
            digiSpotLatLng.longitude,
            skimmerLatLng.latitude,
            skimmerLatLng.longitude);
      }
    }
    return distance;
  }

  @override
  List<Marker> getSpotLayer(List<Spot> spots) {
    List<Marker> markers = [];

    for (var spot in spots) {
      var match =
          _reverseBeaconNodeService.getLatLngByCallsign(spot.skimmerCall);
      if (match != null) {
        markers.add(Marker(
            point: match,
            width: 15,
            height: 15,
            child: Icon(Icons.my_location,
                size: 15, color: spotBandToColor(spot.band))));
      }
    }
    return markers;
  }
  
  @override
  bool getShowBeacons() {
    return _showBeacons;
  }
  
  @override
  void setShowBeacons(bool status) {
    _showBeacons = status;
  }
}
