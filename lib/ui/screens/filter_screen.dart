import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<bool> _selectedBands = <bool>[
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  static const List<Widget> bands = <Widget>[
    Text('2m'),
    Text('6m'),
    Text('10m'),
    Text('12m'),
    Text('15m'),
    Text('17m'),
    Text('20m'),
    Text('30m'),
    Text('40m'),
    Text('60m'),
    Text('80m'),
    Text('160m'),
    Text('630m'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtons(
              direction: Axis.vertical,
              isSelected: _selectedBands,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              children: bands,
              onPressed: (int index) {
                setState(() {
                  _selectedBands[index] = !_selectedBands[index];
                });
              },
            ),
             Chip(label: const Text('N1BRI'), onDeleted: () {return;},),
          ],
        ),
      ),
    );
  }
}
