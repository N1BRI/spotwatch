import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/widgets/filter_drawer.dart';
import 'package:spotwatch/views/widgets/spot_list.dart';
import 'package:spotwatch/views/widgets/spot_map.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  MobileViewState createState() => MobileViewState();
}

class MobileViewState extends State<MobileView> {
  final _reverseBeaconService = getIt<ReverseBeaconService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static final List<Widget> _navOptions = [getIt<SpotList>(), getIt<SpotMap>()];
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
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.info))],
        backgroundColor: const Color.fromARGB(255, 43, 135, 255),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'SPOTWATCH',
          textAlign: TextAlign.justify,
        ),
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
          },
          child: _navOptions.elementAt(_selectedIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleBeaconFeed,
        child:
            _isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 43, 135, 255),
        onTap: _onItemTapped,
      ),
      drawer: const FilterDrawer(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
