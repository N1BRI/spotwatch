import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/band_badge.dart';
import 'package:spotwatch/views/widgets/cw_speed_badge.dart';
import 'package:spotwatch/views/widgets/mode_badge.dart';
import 'package:spotwatch/views/widgets/snr_badge.dart';

class SpotList extends StatefulWidget {
  const SpotList({Key? key}) : super(key: key);

  @override
  State<SpotList> createState() => _SpotListState();
}

class _SpotListState extends State<SpotList> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListenableBuilder(
          listenable: _reverseBeaconService,
          builder: (context, child) => Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                final spot = _reverseBeaconService.getSpot(index);
                if (spot != null) {
                  return ListTile(isThreeLine: true,
                    title: Row(
                      children: [
                        
                        Text(spot.skimmerCall, style: const TextStyle(fontSize: 14, color: Colors.amber, fontWeight: FontWeight.bold),),
                       
                      ],
                    ),
                    trailing: SizedBox(
                      width: 160,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          spot.band != null
                              ? Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                child: BandBadge(spotBand: spot.band!),
                              )
                              : Container(),
                              SnrBadge(snr: spot.db),
                              spot.mode == Mode.cw ? CwSpeedBadge(wpm: (spot as CWSpot).wpm.toString()) : const CwSpeedBadge(wpm: 'n/a')
                        ],
                      ),
                    ),
                    leading: Column(
                      children: [
                        ModeBadge(
                          spotMode: spot.mode,
                        ),
                        Text('${spot.time.hour}:${spot.time.minute}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    subtitle: 
                        Text('${spot.frequency}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  );
                } else {
                  return Container();
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: _reverseBeaconService.getSpotCount(),
            ),
          ),
        ),
      ],
    );
  }
}
