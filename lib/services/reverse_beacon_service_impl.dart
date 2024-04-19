import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/models/filter.dart';

class ReverseBeaconServiceImpl extends ChangeNotifier with Loadable
    implements ReverseBeaconService {
  final ReverseBeacon reverseBeacon;
  final List<Spot> spots = [];
  final List<Filter> filters = [];
  final int rollingSpotCount;
  StreamSubscription<Spot>? _subscription;

  ReverseBeaconServiceImpl(
      {required this.reverseBeacon, this.rollingSpotCount = 20});

  @override
  void addSpot(Spot spot) {
    if (filters.isEmpty) {
      spots.add(spot);
      notifyListeners();
      if (spots.length == rollingSpotCount) {
        removeSpot(spots.removeAt(0));
      }
    } else {
      for (var filter in filters) {
        if (filter.on(spot) && !spots.contains(spot)) {
          spots.add(spot);
          notifyListeners();
          if (spots.length == rollingSpotCount) {
            removeSpot(spots.removeAt(0));
          }
        }
      }
    }
  }

  @override
  void removeSpot(Spot spot) {
    spots.remove(spot);
    notifyListeners();
  }

  @override
  void addFilter(Filter filter) {
    if (!filters.contains(filter)) {
      filters.add(filter);
      notifyListeners();
    }
  }

  @override
  void removeFilter(Filter filter) {
    if (!filters.contains(filter)) {
      filters.remove(filter);
      notifyListeners();
    }
  }

  @override
  Future<bool> connect(String callsign) async {
    bool success = false;
    try {
      await reverseBeacon.connect(callsign: callsign);
      _subscription = reverseBeacon.listen((spot) => addSpot(spot));
      success = true;
    } catch (_) {}
    setLoadingState(false);
    return success;
  }

  @override
  void pause() {
    _subscription?.pause();
  }

  @override
  void resume() {
    _subscription?.resume();
  }

  @override
  void cancel() {
    _subscription?.cancel();
    reverseBeacon.close();
  }

  @override
  Spot? getSpot(int index) {
    if (spots.isNotEmpty && index > 0 && index < spots.length - 1) {
      return spots[index];
    }
    return null;
  }

  @override
  int getSpotCount() {
    return spots.length;
  }

  @override
  bool? isStreamPaused() {
    return _subscription?.isPaused;
  }
}
