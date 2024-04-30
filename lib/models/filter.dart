import 'package:reverse_beacon/reverse_beacon.dart';

class Filter {
  final bool Function(Spot) on;
  final String label;
  final FilterType type;

  Filter({required this.label, required this.on, required this.type});

  static Filter fromCallsign(String callsign, int precedence) {
    return Filter(
        label: callsign,
        on: (c) {
          return c.spottedCall.toUpperCase() == callsign.toUpperCase();
        },
        type: FilterType.callsign);
  }
}

enum FilterType { callsign, band, mode, geographic, other }
