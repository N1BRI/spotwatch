import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/color_helpers.dart';

class BandBadge extends StatelessWidget {
  const BandBadge({Key? key, required this.spotBand}) : super(key: key);
  final Band spotBand;

  @override
  Widget build(BuildContext context) {
    var text = '';
    Color bg = spotBandToColor(spotBand);
    Color font = Colors.white;
    switch (spotBand) {
      case Band.meters160:
        text = '160';
      case Band.meters80:
        text = '80';
      case Band.meters60:
        text = '60';
      case Band.meters40:
        text = '40';
      case Band.meters30:
        text = '30';
      case Band.meters20:
        text = '20';
      case Band.meters17:
        text = '17';
      case Band.meters15:
        text = '15';
      case Band.meters12:
        text = '12';
      case Band.meters10:
        text = '10';
      case Band.meters6:
        text = '6';
        font = Colors.black;
      case Band.meters2:
        text = '2';
        font = Colors.black;
      case Band.meters125:
        text = '1.25';
        font = Colors.black;
      case Band.centimeters70:
        text = '70';
        font = Colors.black;
      case Band.centimeters33:
        text = '33';
        font = Colors.black;
      case Band.centimeters23:
        text = '23';
        font = Colors.black;
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: bg,
         ),
      child: Center(
        child: Text(
          text,
          style:  TextStyle(
              fontSize: 8, color: font, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
