import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/extensions/string_extensions.dart';

class TestTile extends StatelessWidget {
  final Spot spot;

  const TestTile({required this.spot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Icon(Icons.cell_tower, size: 15),
          const SizedBox(
            width: 2,
          ),
          Text(
            spot.skimmerCall,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
      subtitle: Text(spot.toString()),
    );
  }
}
