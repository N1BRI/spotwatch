import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/models/filter.dart';
import 'package:spotwatch/views/widgets/callsign_chip.dart';

class CallsignFilterControl extends StatefulWidget {
  const CallsignFilterControl({Key? key}) : super(key: key);

  @override
  State<CallsignFilterControl> createState() => _CallsignFilterControlState();
}

class _CallsignFilterControlState extends State<CallsignFilterControl> {
  @override
  Widget build(BuildContext context) {
    final reverseBeaconService = getIt<ReverseBeaconService>();
    final callsignTextController = TextEditingController();
    AutovalidateMode validationMode = AutovalidateMode.disabled;
    String? callsign = '';
    return ListenableBuilder(
      listenable: reverseBeaconService,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2, 12, 2, 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Form(
                          autovalidateMode: validationMode,
                          child: TextFormField(
                            controller: callsignTextController,
                            validator: (value) {
                              if (isValidCallsign(value)) {
                                return null;
                              } else {
                                return 'please enter a valid callsign';
                              }
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                validationMode =
                                    AutovalidateMode.onUserInteraction;
                              }
                              callsign = value.toUpperCase().replaceAll(' ', '');
                            },
                            decoration: const InputDecoration(
                                label: Text('Callsign'),
                                helperText: 'Enter a callsign',
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 64, 62, 167))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 64, 62, 167))),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        )),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (callsign != null) {
                          if (isValidCallsign(callsign)) {
                            reverseBeaconService
                                .addFilter(Filter.fromCallsign(callsign!));
                            setState(() {
                              callsign = '';
                              validationMode = AutovalidateMode.disabled;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
              Wrap(
                children: [
                  for (var i in reverseBeaconService.getFilters(
                      filterType: FilterType.callsign))
                    CallsignChip(
                      callsignFilter: i,
                    )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
