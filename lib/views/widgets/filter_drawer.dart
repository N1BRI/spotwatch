import 'package:flutter/material.dart';
import 'package:spotwatch/views/widgets/callsign_filter_control.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  FilterDrawerState createState() => FilterDrawerState();
}

class FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 350,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Text(
              "Filter Spots",
              style: TextStyle(fontSize: 20),
            ),
          ),
          CallsignFilterControl()
        ],
      ),
    );
  }
}
