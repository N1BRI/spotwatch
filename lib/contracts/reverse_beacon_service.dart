import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/models/filter.dart';

abstract class ReverseBeaconService extends ChangeNotifier {
  Spot? getSpot(int index);
  void addSpot(Spot spot);
  void removeSpot(Spot spot);
  void addFilter(Filter filter);
  void removeFilter(Filter filter);
  int getSpotCount();
  Future<bool> connect(String callsign);
  void pause();
  void resume();
  void cancel();
  bool isLoading();
  void setLoadingState(bool isLoading);
  bool? isStreamPaused();
}
