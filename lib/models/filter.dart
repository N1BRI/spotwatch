import 'package:reverse_beacon/reverse_beacon.dart';

class Filter {
  final bool Function(Spot) on;
  final String label;

  Filter({required this.label, required this.on});
}
