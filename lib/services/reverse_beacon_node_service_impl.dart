import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import '../models/node.dart';

class ReverseBeaconNodeServiceImpl extends ChangeNotifier
    with Loadable
    implements ReverseBeaconNodeService {
  final List<Node> _nodes = [];
  @override
  Future<bool> loadBeacons() async {
    setLoadingState(true);
    var success = true;
    try {
      var response = await http.get(Uri.parse(
          'https://www.reversebeacon.net/cont_includes/status.php?t=skt'));
      if (response.statusCode != 200) {
        throw Exception('error fetching beacons');
      }
      var table = '<table>${response.body}</table>';
      var parsedTable = parse(table);
      var rows = parsedTable.getElementsByTagName('tr');
      for (var row in rows) {
        _nodes.add(Node(
            callsign:
                row.children[0].text.replaceAll(' ', '').replaceAll('\n', ''),
            gridSquare:
                row.children[2].text.replaceAll(' ', '').replaceAll('\n', ''),
            dxcc: row.children[3].text.replaceAll(' ', '').replaceAll('\n', ''),
            continent:
                row.children[4].text.replaceAll(' ', '').replaceAll('\n', ''),
            itu:
                row.children[5].text.replaceAll(' ', '').replaceAll('\n', '')));
      }
    } catch (ex) {
      success = false;
    }
    setLoadingState(false);
    return success;
  }

  @override
  List<Node> getBeacons() {
    return _nodes;
  }

  @override
  LatLng getLatLngByCallsign(String callsign) {
    var match = _nodes.where((n) => n.callsign.toUpperCase() == callsign.toUpperCase()).firstOrNull!;
    return match.latLng;
  }
}
