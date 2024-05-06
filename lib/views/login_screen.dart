import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  final _geolocatorService = getIt<GeolocationService>();
  final _reverseBeaconNodeService = getIt<ReverseBeaconNodeService>();
  final _mapService = getIt<MapService>();
  bool _isValidCallsign = false;
  String? _callsign;

  @override
  void initState() {
    super.initState();
    if(Platform.isLinux){

    }else{
      _checkLocationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 145, 187, 221),
              Colors.white,
              Color.fromARGB(255, 145, 187, 221),
            ],
          )),
          child: Center(
            child: SingleChildScrollView(
              child: ListenableBuilder(
                listenable: Listenable.merge(
                    [_reverseBeaconService, _reverseBeaconNodeService]),
                builder: (context, child) {
                  if (_reverseBeaconService.isLoading()) {
                    return const Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Connecting to Reverse Beacon Telnet Servers')
                      ],
                    ));
                  } else if (_reverseBeaconNodeService.isLoading()) {
                    return const Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Retrieving Reverse Beacon Node List')
                      ],
                    ));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'SPOTWATCH',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 64, 62, 167)),
                        ),
                        const Icon(
                          Icons.radar_sharp,
                          size: 200,
                          color: Color.fromARGB(255, 64, 62, 167),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            constraints: const BoxConstraints(
                                minWidth: 200, maxWidth: 300),
                            child: Form(
                              child: TextFormField(
                                validator: (value) {
                                  if (isValidCallsign(value)) {
                                    return null;
                                  } else {
                                    return 'please enter a valid callsign';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _isValidCallsign = isValidCallsign(value);
                                    _callsign = value;
                                  });
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    label: Text('Callsign'),
                                    helperText: 'Enter your callsign',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 64, 62, 167))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 64, 62, 167))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: _isValidCallsign ? _connect : null,
                            child: const Text("Start Listening")),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }

  void _connect() async {
    if (isValidCallsign(_callsign)) {
      if (await _reverseBeaconService.connect(_callsign!.replaceAll(' ', '').toUpperCase())) {
        if (await _reverseBeaconNodeService.loadBeacons()) {
          setState(() {
            Navigator.pushNamed(context, '/main');
          });
        }
      }
    }
  }

  Future<void> _checkLocationPermission() async {
    var isLocationGranted =
        await _geolocatorService.isLocationPermissionGranted();
    await Future.delayed(const Duration(milliseconds: 800));
    if (!isLocationGranted) {
      setState(() {
        Navigator.pushNamed(context, '/disconnected');
      });
    } else {
      var coords = await _geolocatorService.setUserLocation();
      _mapService.setPosition(MapPosition(center: coords, zoom: 8.0));
    }
  }
}
