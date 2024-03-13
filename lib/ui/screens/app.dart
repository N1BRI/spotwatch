import 'package:flutter/material.dart';
import 'package:spotwatch/data/reverse_beacon/reverse_beacon_livefeed.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 80, 185),
        foregroundColor: Colors.white,
        title: const Text('SPOTWATCH'),
      ),
      body: const ReverseBeaconLivefeed(),
    );
  }
}
