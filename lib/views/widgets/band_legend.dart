import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/views/widgets/band_badge.dart';

class BandLegend extends StatelessWidget {
  const BandLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Wrap(direction: Axis.horizontal,
      children: [
        BandBadge(spotBand: Band.meters160),
        BandBadge(spotBand: Band.meters80),
        BandBadge(spotBand: Band.meters60),
        BandBadge(spotBand: Band.meters40),
        BandBadge(spotBand: Band.meters30),
        BandBadge(spotBand: Band.meters20),
        BandBadge(spotBand: Band.meters17),
        BandBadge(spotBand: Band.meters15),
        BandBadge(spotBand: Band.meters12),
        BandBadge(spotBand: Band.meters10),
        BandBadge(spotBand: Band.meters6),
        BandBadge(spotBand: Band.meters2),

        
      ],
    );
  }
}
