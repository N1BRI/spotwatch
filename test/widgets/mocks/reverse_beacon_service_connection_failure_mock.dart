import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/loadable.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/models/filter.dart';

class RBConnFailureMock extends ChangeNotifier
    with Loadable
    implements ReverseBeaconService {
  final ReverseBeacon reverseBeacon;
  List<Spot> _spots = [];
  final List<Filter> _callsignFilters = [];
  final List<Filter> _bandFilters = [];
  final List<Filter> _modeFilters = [];
  final int rollingSpotCount;
  String? _callsign;
  StreamSubscription<Spot>? _subscription;

  RBConnFailureMock(
      {required this.reverseBeacon, this.rollingSpotCount = 15});

  @override
  void addSpot(Spot spot) {
    bool matchesFilters = true;
    if (_callsignFilters.isEmpty && _bandFilters.isEmpty && _modeFilters.isEmpty) {
      _spots.insert(0,spot);
      if (_spots.length == rollingSpotCount) {
        removeSpot(_spots.removeAt(_spots.length - 1));
      }
      notifyListeners();
      return;
    } else {
      for (var filter in _callsignFilters) {
        if (filter.on(spot) && !_spots.contains(spot)) {
          matchesFilters = true;
          break;
        } else {
          matchesFilters = false;
        }
      }
      if (matchesFilters) {
        for (var filter in _bandFilters) {
          if (filter.on(spot) && !_spots.contains(spot)) {
            matchesFilters = true;
            break;
          } else {
            matchesFilters = false;
          }
        }
      }
      if (matchesFilters) {
        for (var filter in _modeFilters) {
          if (filter.on(spot) && !_spots.contains(spot)) {
            matchesFilters = true;
            break;
          } else {
            matchesFilters = false;
          }
        }
      }
      if (matchesFilters) {
        _spots.insert(0,spot);
        if (_spots.length == rollingSpotCount) {
          removeSpot(_spots.removeAt(_spots.length - 1));
        }
        notifyListeners();
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
    List<Spot> filteredSpots = [];
    switch (filter.type) {
      case FilterType.callsign:
        if (!_callsignFilters.contains(filter)) {
          _callsignFilters.add(filter);
          for (var f = 0; f < _callsignFilters.length; f++) {
            for (var s = 0; s < _spots.length; s++) {
              if (_callsignFilters[f].on(_spots[s])) {
                filteredSpots.add(_spots[s]);
              }
            }
          }
        }
      case FilterType.band:
        if (!_bandFilters.contains(filter)) {
          _bandFilters.add(filter);
          for (var f = 0; f < _bandFilters.length; f++) {
            for (var s = 0; s < _spots.length; s++) {
              if (_bandFilters[f].on(_spots[s])) {
                filteredSpots.add(_spots[s]);
              }
            }
          }
        }
      case FilterType.mode:
        if (!_modeFilters.contains(filter)) {
          _modeFilters.add(filter);
          for (var f = 0; f < _modeFilters.length; f++) {
            for (var s = 0; s < _spots.length; s++) {
              if (_modeFilters[f].on(_spots[s])) {
                filteredSpots.add(_spots[s]);
              }
            }
          }
        }
      case FilterType.geographic:
      // TODO: Handle this case.
      case FilterType.other:
      // TODO: Handle this case.
    }
    _spots = filteredSpots;
    notifyListeners();
  }

  @override
  void removeFilter(Filter filter) {
      
    switch(filter.type){
      
      case FilterType.callsign:
         _callsignFilters.remove(filter);
      case FilterType.band:
        _bandFilters.remove(filter);
      case FilterType.mode:
        _modeFilters.remove(filter);
      case FilterType.geographic:
        // TODO: Handle this case.
      case FilterType.other:
        // TODO: Handle this case.
    }
    var orphanedSpots = _getOrphanedSpots(filter);
    _spots.removeWhere((s) => orphanedSpots.any((os) => os == s));
    notifyListeners();
  }

  List<Spot> _getOrphanedSpots(Filter filter){
    List<Spot> orphanedSpots = [];
    for(int i = 0; i < _spots.length; i++){
      if(filter.on(_spots[i])){
        orphanedSpots.add(_spots[i]);
      }
    }
    for(int i = 0; i < orphanedSpots.length; i++){
      if(_bandFilters.any((f) => f.on(orphanedSpots[i]))){
        orphanedSpots.remove(orphanedSpots[i]);
      }
      else if(_callsignFilters.any((f) => f.on(orphanedSpots[i]))){
        orphanedSpots.remove(orphanedSpots[i]);
      }
      else if(_modeFilters.any((f) => f.on(orphanedSpots[i]))){
        orphanedSpots.remove(orphanedSpots[i]);
      }
    }
    return orphanedSpots;
  }

  @override
  Future<bool> connect(String callsign) async {
    return false;
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
    if (_spots.isNotEmpty && index >= 0 && index <= _spots.length - 1) {
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

  @override
  List<Filter> getFilters({required FilterType filterType}) {
    switch (filterType) {
      case FilterType.callsign:
        return _callsignFilters;
      case FilterType.band:
        return _bandFilters;
      case FilterType.mode:
        return _modeFilters;
      case FilterType.geographic:
        return [];
      case FilterType.other:
        return [];
    }
  }

  @override
  void flushSpots() {
    _spots = [];
  }
}
