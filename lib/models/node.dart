import 'package:gridlocator/gridlocator.dart';
import 'package:latlong2/latlong.dart';

class Node {
  final String callsign;
  final String gridSquare;
  final String dxcc;
  final String continent;
  final String itu;
  late LatLng latLng;
  Node(
      {required this.callsign,
      required this.gridSquare,
      required this.dxcc,
      required this.continent,
      required this.itu}) {
    var point = Gridlocator.decode(gridSquare);
    latLng = LatLng(point.latitude, point.longitude);
  }
}
