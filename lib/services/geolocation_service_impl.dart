import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/loadable.dart';

class GeolocationServiceImpl extends ChangeNotifier with Loadable
    implements GeolocationService {
  LatLng? position;
  GeolocationServiceImpl();
  @override
  LatLng getPostionFromGridSquare(String gridSquare) {
    // TODO: implement getPostionFromGridSquare
    throw UnimplementedError();
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    var status = await Geolocator.checkPermission();
    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }
  
  @override
  Future<LatLng?> setUserLocation() async{
    var currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    position = LatLng(currentPosition.latitude, currentPosition.longitude);
    return position;
  }
  
  @override
  LatLng? getUserLocation() {
    return position;
  }
}
