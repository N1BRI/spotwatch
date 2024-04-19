import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DisconnectedScreen extends StatefulWidget {
  const DisconnectedScreen({Key? key}) : super(key: key);

  @override
  State<DisconnectedScreen> createState() => _DisconnectedScreenState();
}

class _DisconnectedScreenState extends State<DisconnectedScreen>
    with WidgetsBindingObserver {
  late AppLifecycleState _notification;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _checkLocationPermission() async {
     var status = await Geolocator.checkPermission();
    await Future.delayed(const Duration(milliseconds: 800));

    if (status == LocationPermission.always || status == LocationPermission.whileInUse ) {
      setState(() {
        Navigator.pushNamed(context, '/');
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    setState(() {
      _notification = state;
    });
    if (_notification == AppLifecycleState.resumed) {
      await _checkLocationPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Connection Error'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 200,
                color: Color.fromARGB(255, 64, 62, 167),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(style: TextStyle(fontSize: 24), 'Sorry'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  'Spotwatch requires an internet connection and location permission in order to operate.'),
              const Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  'Please ensure you have internet connection and that location permissions have been granted.'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Geolocator.openAppSettings();
                  },
                  child: const Text('Open App Settings'))
            ],
          ),
        ),
      ),
    );
  }
}
