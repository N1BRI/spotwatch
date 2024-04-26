import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/extensions/string_extensions.dart';
import 'package:spotwatch/views/widgets/icon_label_small.dart';
import 'package:spotwatch/views/widgets/mode_badge.dart';

class SpotTile extends StatelessWidget {
  final Spot spot;

  const SpotTile({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      dense: true,
      title: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3.0, 0, 0.0, 0),
          child: Row(
            children: [
              const Icon(Icons.cell_tower, size: 25, color: Colors.white),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${spot.skimmerCall} - ${spot.frequency} KHz',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 0.0, 0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconLabelSmall(
                          icon: const Icon(
                            Icons.hearing,
                            color: Color(0xff40568d),
                            size: 15,
                          ),
                          labelText: Text(
                            spot.spottedCall.limitChars(8),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        IconLabelSmall(
                          icon: const Icon(
                            Icons.volume_up,
                            color: Color(0xff40568d),
                            size: 15,
                          ),
                          labelText: Text(
                            '${spot.db} dB',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconLabelSmall(
                        icon: const Icon(
                          Icons.schedule,
                          color: Color(0xff40568d),
                          size: 15,
                        ),
                        labelText: Text(
                          DateFormat('HH:mm').format(spot.time),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      IconLabelSmall(
                        icon: const Icon(
                          Icons.title,
                          color: Color(0xff40568d),
                          size: 15,
                        ),
                        labelText: Text(
                          spot.spotType
                              .toString()
                              .split('.')
                              .last
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                      (spot.mode == Mode.ft8 || spot.mode == Mode.ft8)
                          ? IconLabelSmall(
                              icon: const Icon(
                                Icons.grid_on,
                                color: Color(0xff40568d),
                                size: 15,
                              ),
                              labelText: Text(
                                (spot as DigiSpot).gridSquare ?? '--',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )
                          : IconLabelSmall(
                              icon: const Icon(
                                Icons.speed,
                                color: Color(0xff40568d),
                                size: 15,
                              ),
                              labelText: Text(
                                spot.mode == Mode.cw
                                    ? '${(spot as CWSpot).wpm.toString()} wpm'
                                    : '--',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      const IconLabelSmall(
                        icon: Icon(
                          Icons.connect_without_contact,
                          color: Color(0xff40568d),
                          size: 17,
                        ),
                        labelText: Text(
                          '1445mi',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ModeBadge(spotMode: spot.mode),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
