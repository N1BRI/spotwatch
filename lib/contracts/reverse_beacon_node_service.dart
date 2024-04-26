import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/loadable.dart';

import '../models/node.dart';

abstract class ReverseBeaconNodeService extends ChangeNotifier with Loadable {
  Future<bool> loadBeacons();
  List<Node> getBeacons();
  LatLng? getLatLngByCallsign(String callsign);
}
