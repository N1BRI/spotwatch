import 'package:flutter/material.dart';
import 'package:spotwatch/contracts/connectivity_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/views/desktop_view.dart';
import 'package:spotwatch/views/mobile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _connectivityService = getIt<ConnectivityService>();
  bool isLocationPermissionGranted = false;
  @override
  void initState() {
    super.initState();
    _connectivityService.addListener(() {
      if (!_connectivityService.hasInternetConnection()) {
        Navigator.pushNamed(context, '/disconnected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1000) {
          return const DesktopView();
        } else {
          return const MobileView();
        }
      },
    );
  }

}
