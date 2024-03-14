import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/reverse_beacon_livefeed.dart';
import 'package:spotwatch/ui/screens/widgets/filter_screen.dart';
import 'package:spotwatch/ui/screens/widgets/spots_map_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  bool _isVisible = false;
  static const List<Widget> _navOptions = <Widget>[
    FilterScreen(),
    ReverseBeaconLivefeed(),
    SpotsMapScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.info))],
        automaticallyImplyLeading: false,
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
        visible: _isVisible,
          child: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.pause),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: 'Filter',
          ),
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isVisible = index > 0;
      BlocProvider.of<ReverseBeaconBloc>(context)
          .add(const ReverseBeaconWaiting());
    });
  }
}
