import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/loadable.dart';

abstract class GeolocationService extends ChangeNotifier with Loadable{
  Future<LatLng?> setUserLocation();
  LatLng? getUserLocation();
  LatLng getPostionFromGridSquare(String gridSquare);
  Future<bool> isLocationPermissionGranted();
}