import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';
import 'package:spotwatch/models/enums.dart';
import 'package:spotwatch/ui/screens/widgets/reverse_beacon_list.dart';
import 'package:spotwatch/ui/screens/spots_map_screen.dart';

class MainScreenMobile extends StatefulWidget {
  const MainScreenMobile({Key? key}) : super(key: key);

  @override
  State<MainScreenMobile> createState() => _MainScreenMobileState();
}

class _MainScreenMobileState extends State<MainScreenMobile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  bool _isRunning = true;
  static const List<Widget> _navOptions = <Widget>[
    ReverseBeaconList(),
    SpotsMapScreen()
  ];
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
      body: _navOptions.elementAt(_selectedIndex),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: _toggleBeaconFeed,
        child:
            _isRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      )),
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
      drawer: const Drawer(
        child: Column(
          children: [Text('test')],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isRunning = BlocProvider.of<ReverseBeaconBloc>(context).state.reverseBeaconStatus != ReverseBeaconStatus.paused;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      BlocProvider.of<ReverseBeaconBloc>(context)
          .add(const ReverseBeaconListening());
    });
  }
  
  void _toggleBeaconFeed() {
    setState(() {
      if (_isRunning) {
        BlocProvider.of<ReverseBeaconBloc>(context)
            .add(const ReverseBeaconPaused());
      } else {
        BlocProvider.of<ReverseBeaconBloc>(context)
            .add(const ReverseBeaconResumed());
      }
      _isRunning = !_isRunning;
    });
  }
}
