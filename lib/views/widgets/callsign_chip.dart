import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/models/filter.dart';

class CallsignChip extends StatelessWidget {
const CallsignChip({ Key? key, required this.callsignFilter }) : super(key: key);
final Filter callsignFilter;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Chip(label: Text(callsignFilter.label), onDeleted: () {
        getIt<ReverseBeaconService>().removeFilter(callsignFilter);
      },),
    );
  }
}