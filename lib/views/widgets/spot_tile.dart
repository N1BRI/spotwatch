import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/extensions/string_extensions.dart';
import 'package:spotwatch/views/widgets/band_badge.dart';
import 'package:spotwatch/views/widgets/mode_badge.dart';

class SpotTile extends StatelessWidget {
  const SpotTile({Key? key, required this.spot}) : super(key: key);
  final Spot spot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ModeBadge(spotMode: spot.mode),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(DateFormat('HH:mm').format(spot.time),
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 95,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.cell_tower, size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        spot.skimmerCall,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.visibility, size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        spot.spottedCall.limitChars(7),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                spot.band != null
                    ? BandBadge(spotBand: spot.band!)
                    : Container(),
                Text(
                  spot.frequency.toString(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            width: 95,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.speed, size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        spot.mode == Mode.cw
                            ? (spot as CWSpot).wpm.toString()
                            : 'N/A',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.volume_up, size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        spot.db.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
