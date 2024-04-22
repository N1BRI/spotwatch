import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/connectivity_service.dart';

class ConnectivityServiceImpl extends ChangeNotifier
    implements ConnectivityService {
  bool _isConnected = false;
  final Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  ConnectivityServiceImpl({required this.connectivity}) {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(connectionStatusChanged);
  }
  @override
  void connectionStatusChanged(List<ConnectivityResult> event) async {
    var result = await connectivity.checkConnectivity();
    if (result.any(
      (connectionType) {
        return [
          ConnectivityResult.mobile,
          ConnectivityResult.wifi,
          ConnectivityResult.ethernet,
          ConnectivityResult.vpn
        ].contains(connectionType);
      },
    )) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }
    Future.delayed(Duration.zero, notifyListeners);
  }

  @override
  bool hasInternetConnection() {
    return _isConnected;
  }
}
