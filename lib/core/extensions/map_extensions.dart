import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

extension MapBuilding on MapPosition {
  MapPosition copyWith({
    LatLng? center,
    LatLngBounds? bounds,
    double? zoom,
    bool? hasGesture,
  }) {
    return MapPosition(
        center: center ?? this.center,
        bounds: bounds ?? this.bounds,
        zoom: zoom ?? this.zoom,
        hasGesture: hasGesture ?? this.hasGesture);
  }
}
