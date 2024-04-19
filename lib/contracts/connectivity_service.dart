import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class ConnectivityService extends ChangeNotifier {
  void connectionStatusChanged(List<ConnectivityResult> event);
  bool hasInternetConnection();
}
