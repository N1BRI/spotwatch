import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/band_badge.dart';
import 'package:spotwatch/views/widgets/mode_badge.dart';

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
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final spot = _reverseBeaconService.getSpot(index);
                if (spot != null) {
                  return ListTile(
                    title: Text('${spot.skimmerCall} - ${spot.spottedCall}'),
                    dense: true,
                    trailing: spot.band != null ? BandBadge(spotBand: spot.band!) : Container(),
                    leading: ModeBadge(spotMode: spot.mode,),
                    subtitle: Text('${spot.frequency} @ ${spot.time.hour}:${spot.time.minute}'),
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
