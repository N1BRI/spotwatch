import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/spot_list.dart';
import 'package:spotwatch/views/widgets/spot_map.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  DesktopViewState createState() => DesktopViewState();
}

class DesktopViewState extends State<DesktopView> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPaused = getIt<ReverseBeaconService>().isStreamPaused() ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons
              .filter_alt), // Change this to your desired icon (e.g., Icons.settings)
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.info))],
        backgroundColor: const Color.fromARGB(255, 43, 135, 255),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'SPOTWATCH',
          textAlign: TextAlign.justify,
        ),
      ),
      drawer: const Drawer(
        width: 400,
        child: Column(
          children: [Text("Drawer")],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: FloatingActionButton(
          onPressed: _toggleBeaconFeed,
          child: _isPaused
              ? const Icon(Icons.play_arrow)
              : const Icon(Icons.pause),
        ),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  width: 700,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Color.fromARGB(221, 211, 211, 211),
                              width: 2))),
                  child: const SpotList())),
          const Expanded(flex: 6, child: SpotMap())
        ],
      ),
    );
  }

  void _toggleBeaconFeed() {
    setState(() {
      var streamIsPaused = _reverseBeaconService.isStreamPaused() ?? false;
      if (streamIsPaused) {
        _reverseBeaconService.resume();
      } else {
        _reverseBeaconService.pause();
      }
      _isPaused = !streamIsPaused;
    });
  }
}
