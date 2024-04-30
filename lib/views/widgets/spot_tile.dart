import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/core/color_helpers.dart';
import 'package:spotwatch/core/extensions/string_extensions.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/icon_label_small.dart';

class SpotTile extends StatelessWidget {
  final Spot spot;
  late final double? spotDistanceM;
  late final String distance;
  SpotTile({super.key, required this.spot}){
    spotDistanceM = getIt<MapService>().getSpotDistanceMeters(spot);
    if(spotDistanceM != null){
      distance = '${(spotDistanceM! * 0.00062137).truncate()}mi';
    }
    else{
      distance = '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
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
              SelectableText(
                '${spot.skimmerCall} - ${spot.frequency} KHz - ${spot.mode.toString().split('.').last.toUpperCase()}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),const SizedBox(width: 8,),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  color: spotBandToColor(spot.band),
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.0,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          children: [
            IconLabelSmall(
              maxWidth: 100,
              icon: const Icon(
                Icons.hearing,
                color: Color(0xff40568d),
                size: 15,
              ),
              labelText: SelectableText(
                spot.spottedCall.limitChars(6),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            IconLabelSmall(
              maxWidth: 100,
              icon: const Icon(
                Icons.volume_up,
                color: Color(0xff40568d),
                size: 15,
              ),
              labelText: SelectableText(
                '${spot.db} dB',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            IconLabelSmall(
              maxWidth: 100,
              icon: const Icon(
                Icons.schedule,
                color: Color(0xff40568d),
                size: 15,
              ),
              labelText: SelectableText(
                DateFormat('HH:mm').format(spot.time),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            IconLabelSmall(
              maxWidth: 100,
              icon: const Icon(
                Icons.title,
                color: Color(0xff40568d),
                size: 15,
              ),
              labelText: SelectableText(
                spot.spotType.toString().split('.').last.toUpperCase(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            (spot.mode == Mode.ft8 || spot.mode == Mode.ft4)
                ? IconLabelSmall(
                    maxWidth: 100,
                    icon: const Icon(
                      Icons.grid_on,
                      color: Color(0xff40568d),
                      size: 15,
                    ),
                    labelText: SelectableText(
                      (spot as DigiSpot).gridSquare ?? '--',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                : IconLabelSmall(
                    maxWidth: 100,
                    icon: const Icon(
                      Icons.speed,
                      color: Color(0xff40568d),
                      size: 15,
                    ),
                    labelText: SelectableText(
                      spot.mode == Mode.cw
                          ? '${(spot as CWSpot).wpm.toString()} wpm'
                          : '--',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
             IconLabelSmall(
              maxWidth: 100,
              icon: const Icon(
                Icons.connect_without_contact,
                color: Color(0xff40568d),
                size: 17,
              ),
              labelText: SelectableText(
                distance,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            // ModeBadge(spotMode: spot.mode),
          ],
        ),
      ),
    );
  }


}
