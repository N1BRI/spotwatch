import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/extensions/string_extensions.dart';
import 'package:spotwatch/views/widgets/band_badge.dart';
import 'package:spotwatch/views/widgets/icon_label_small.dart';
import 'package:spotwatch/views/widgets/mode_badge.dart';

class SpotTile extends StatelessWidget {
  final Spot spot;

  const SpotTile({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return ListTile(dense: false,
      title: Row(
        children: [
          const Icon(Icons.cell_tower, size: 25),
          const SizedBox(
            width: 4,
          ),
          Text(
            '${spot.skimmerCall} - ${spot.frequency} KHz',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
      
      subtitle: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconLabelSmall(
                        icon: const Icon(
                          Icons.hearing,
                          color: Color.fromARGB(255, 110, 107, 107),
                          size: 15,
                        ),
                        labelText: Text(
                          spot.spottedCall.limitChars(8),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 24, 104, 170)),
                        ),
                      ),
                      IconLabelSmall(
                        icon: const Icon(
                          Icons.volume_up,
                          color: Color.fromARGB(255, 110, 107, 107),
                          size: 15,
                        ),
                        labelText: Text(
                          '${spot.db} dB',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 24, 104, 170)),
                        ),
                      )
                    ]),
              ),
              
              SizedBox(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconLabelSmall(
                      icon: const Icon(
                        Icons.schedule,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        DateFormat('HH:mm').format(spot.time),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    ),
                    IconLabelSmall(
                      icon: const Icon(
                        Icons.title,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        spot.spotType.toString().split('.').last,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    )
                  ],
                ),
              ),
              
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (spot.mode == Mode.ft8 || spot.mode == Mode.ft8) ?
                    IconLabelSmall(
                      icon: const Icon(
                        Icons.grid_on,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        (spot as DigiSpot).gridSquare ?? '--',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    ) : IconLabelSmall(
                      icon: const Icon(
                        Icons.speed,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        spot.mode == Mode.cw ? '${(spot as CWSpot).wpm.toString()} wpm' : '--',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    ) ,
                    IconLabelSmall(
                      icon: const Icon(
                        Icons.radio,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        spot.frequency.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IconLabelSmall(
                      icon: Icon(
                        Icons.connect_without_contact,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        '1245mi',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    ),
                    IconLabelSmall(
                      icon: const Icon(
                        Icons.videogame_asset,
                        color: Color.fromARGB(255, 110, 107, 107),
                        size: 15,
                      ),
                      labelText: Text(
                        spot.mode.toString().split('.').last.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 24, 104, 170)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
