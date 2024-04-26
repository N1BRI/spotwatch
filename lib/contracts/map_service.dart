import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/loadable.dart';

abstract class MapService extends ChangeNotifier with Loadable {
  MapController getMapController();
  List<Marker> getSpotLayer(List<Spot> spots);
  List<Marker> getNodeMarkers();
  MapPosition getPosition();
  void setPosition(MapPosition position);
  double? getSpotDistanceMeters(Spot spottedCall);
}
