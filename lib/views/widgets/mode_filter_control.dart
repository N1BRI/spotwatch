import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/models/filter.dart';

class ModeFilterControl extends StatefulWidget {
  const ModeFilterControl({Key? key}) : super(key: key);

  @override
  ModeFilterControlState createState() => ModeFilterControlState();
}

class ModeFilterControlState extends State<ModeFilterControl> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Mode',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 80, maxWidth: 320),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              for (var b in Mode.values.where((type) => type != Mode.na))
                Column(
                  children: [
                    Text(b.toString().toUpperCase().split('.').last),
                    ListenableBuilder(
                      listenable: _reverseBeaconService,
                      builder: (BuildContext context, Widget? child) {
                        return Switch(
                          value: _reverseBeaconService
                              .getFilters(filterType: FilterType.mode)
                              .where((f) =>
                                  f.label ==
                                  b.toString().toUpperCase().split('.').last).toList()
                              .isNotEmpty,
                          onChanged: (value) {
                            if (value == true) {
                              setState(() {
                                _reverseBeaconService.addFilter(Filter(
                                    label: b
                                        .toString()
                                        .toUpperCase()
                                        .split('.')
                                        .last,
                                    on: (s) {
                                      return s.mode == b;
                                    },
                                    type: FilterType.mode));
                              });
                            } else {
                              var filterToRemove = _reverseBeaconService
                                  .getFilters(filterType: FilterType.mode)
                                  .where((f) =>
                                      f.label ==
                                      b
                                          .toString()
                                          .toUpperCase()
                                          .split('.')
                                          .last)
                                  .toList()
                                  .firstOrNull;
                              if (filterToRemove != null) {
                                _reverseBeaconService
                                    .removeFilter(filterToRemove);
                              }
                            }
                          },
                        );
                      },
                    )
                  ],
                )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
