import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';
import 'package:spotwatch/models/enums.dart';
import 'package:spotwatch/ui/screens/filter_screen.dart';
import 'package:spotwatch/ui/screens/spots_map_screen.dart';
import 'package:spotwatch/ui/screens/widgets/reverse_beacon_list.dart';

class MainScreenDesktop extends StatefulWidget {
  const MainScreenDesktop({Key? key}) : super(key: key);

  @override
  _MainScreenDesktopState createState() => _MainScreenDesktopState();
}

class _MainScreenDesktopState extends State<MainScreenDesktop> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRunning = true;
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
      body: Row(
        children: [
          Container(
            width: 420,
            constraints: const BoxConstraints(
              minWidth: 420, // Maintains fixed width
              minHeight: 800, // Sets minimum height for the first column
            ),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  ReverseBeaconList(),
                ],
              ),
            ),
          ),

          // Second column with remaining space (Expanded)
          Expanded(
            child: Container(
              color: Colors.grey[200], // Optional background color
              child: const Center(
                child: SpotsMapScreen(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
          child: FloatingActionButton(
        onPressed: _toggleBeaconFeed,
        child:
            _isRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      )),
      drawer: const Drawer(width: 400,
        child: Column(
          children: [FilterScreen()],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isRunning = BlocProvider.of<ReverseBeaconBloc>(context).state.reverseBeaconStatus != ReverseBeaconStatus.paused;
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
