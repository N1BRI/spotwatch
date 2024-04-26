import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/spot_tile.dart';
import 'package:spotwatch/views/widgets/spot_tile.dart';

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
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final spot = _reverseBeaconService.getSpot(index);
                if (spot != null) {
                  return SpotTile(spot: spot);
                } else {
                  return Container();
                }
              },
              itemCount: _reverseBeaconService.getSpotCount(), 
              
            ),
          ),
        ),
      ],
    );
  }
}
