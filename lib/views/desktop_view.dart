import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/filter_drawer.dart';
import 'package:spotwatch/views/widgets/info_alert.dart';
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
          icon: const Icon(Icons.filter_alt),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await PackageInfo.fromPlatform().then(
                  (packageInfo) {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => InfoAlert(
                              packageInfo: packageInfo,
                            ));
                  },
                );
              },
              icon: const Icon(Icons.info))
        ],
        backgroundColor: const Color.fromARGB(255, 43, 135, 255),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'SPOTWATCH',
          textAlign: TextAlign.justify,
        ),
      ),
      drawer: const FilterDrawer(),
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
              flex: 4,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              color: Color.fromARGB(221, 211, 211, 211),
                              width: 2))),
                  child: const SpotList())),
          const Expanded(flex: 10, child: SpotMap())
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
