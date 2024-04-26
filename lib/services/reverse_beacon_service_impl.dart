import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/models/filter.dart';

class ReverseBeaconServiceImpl extends ChangeNotifier
    with Loadable
    implements ReverseBeaconService {
  final ReverseBeacon reverseBeacon;
  final List<Spot> _spots = [];
  final List<Filter> filters = [];
  final int rollingSpotCount;
  String? _callsign;
  StreamSubscription<Spot>? _subscription;

  ReverseBeaconServiceImpl(
      {required this.reverseBeacon, this.rollingSpotCount = 50});

  @override
  void addSpot(Spot spot) {
    if (filters.isEmpty) {
      _spots.add(spot);
      notifyListeners();
      if (_spots.length == rollingSpotCount) {
        removeSpot(_spots.removeAt(0));
      }
    } else {
      for (var filter in filters) {
        if (filter.on(spot) && !_spots.contains(spot)) {
          _spots.add(spot);
          notifyListeners();
          if (_spots.length == rollingSpotCount) {
            removeSpot(_spots.removeAt(0));
          }
        }
      }
    }
  }

  @override
  void removeSpot(Spot spot) {
    _spots.remove(spot);
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
    this._callsign = callsign;
    bool success = false;
    try {
      await reverseBeacon.connect(callsign: this._callsign);
      _subscription = reverseBeacon.listen((spot) => addSpot(spot));
      // filters.add(Filter(
      //   label: callsign,
      //   on: (p0) {
      //     return p0.spottedCall.toUpperCase() == callsign.toUpperCase();
      //   },
      // ));
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
    if (_spots.isNotEmpty && index > 0 && index < _spots.length - 1) {
      return _spots[index];
    }
    return null;
  }

  @override
  int getSpotCount() {
    return _spots.length;
  }

  @override
  bool? isStreamPaused() {
    return _subscription?.isPaused;
  }
  
  @override
  List<Spot> getSpots() {
    return _spots;
  }
  
  @override
  String? getCallsign() {
    return _callsign;
  }
}
