import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';

class BandBadge extends StatelessWidget {
  const BandBadge({Key? key, required this.spotBand}) : super(key: key);
  final Band spotBand;

  @override
  Widget build(BuildContext context) {
    var text = '';
    Color bg = const Color(0xff2b87ff);
    switch (spotBand) {
      case Band.meters160:
        text = '160m';
      case Band.meters80:
        text = '80m';
      case Band.meters60:
        text = '60m';
      case Band.meters40:
        text = '40m';
      case Band.meters30:
        text = '30m';
      case Band.meters20:
        text = '20m';
      case Band.meters17:
        text = '17m';
      case Band.meters15:
        text = '15m';
      case Band.meters12:
        text = '12m';
      case Band.meters10:
        text = '10m';
      case Band.meters6:
        text = '6m';
      case Band.meters2:
        text = '2m';
      case Band.meters125:
        text = '1.25m';
      case Band.centimeters70:
        text = '70cm';
      case Band.centimeters33:
        text = '33cm';
      case Band.centimeters23:
        text = '23cm';
    }
    return Container(
      width: 50,
      height: 30,
      decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.all(
            Radius.elliptical(13, 13),
          )),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
