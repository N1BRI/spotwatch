import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/core/extensions/band_extensions.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/models/filter.dart';

class BandFilterControl extends StatefulWidget {
  const BandFilterControl({Key? key}) : super(key: key);
  @override
  BandFilterControlState createState() => BandFilterControlState();
}

class BandFilterControlState extends State<BandFilterControl> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Divider(),
          const Text('Band', style: TextStyle(fontWeight: FontWeight.bold),),
          Container(constraints: const BoxConstraints(maxHeight: 180, maxWidth: 320),
            child: Wrap(direction: Axis.vertical,
              children: [
                for (var b in Band.values.where((band) => ![Band.centimeters23, Band.centimeters33, Band.centimeters70, Band.meters125].any((bb) => bb == band)))
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        ListenableBuilder(
                          listenable: _reverseBeaconService,
                          builder: (BuildContext context, Widget? child) {
                            return Checkbox(
                                value: _reverseBeaconService
                                    .getFilters(filterType: FilterType.band)
                                    .where((f) => f.label == b.getString()).toList()
                                    .isNotEmpty,
                                onChanged: (value) {
                                  if (value == true) {
                                    _reverseBeaconService.addFilter(Filter(
                                        label: b.getString(),
                                        on: (s) {
                                          return s.band == b;
                                        },
                                        type: FilterType.band));
                                  } else {
                                    var filterToRemove = _reverseBeaconService
                                        .getFilters(filterType: FilterType.band)
                                        .where((f) => f.label == b.getString()).toList()
                                        .firstOrNull;
                                        if(filterToRemove != null){
                                          _reverseBeaconService.removeFilter(filterToRemove);
                                        }
                                  }
                                });
                          },
                        ),
                        Text(b.getString())
                      ],
                    ),
                  )
              ],
            ),
          ),
        const Divider()],
    );
  }
}
