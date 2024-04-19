import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/connectivity_service.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/services/connectivity_service_impl.dart';
import 'package:spotwatch/services/geolocation_service_impl.dart';
import 'package:spotwatch/services/map_service_impl.dart';
import 'package:spotwatch/services/reverse_beacon_node_service_impl.dart';
import 'package:spotwatch/services/reverse_beacon_service_impl.dart';
import 'package:spotwatch/views/disconnected_screen.dart';
import 'package:spotwatch/views/login_screen.dart';
import 'package:spotwatch/views/main_screen.dart';
import 'package:spotwatch/views/widgets/spot_list.dart';
import 'package:spotwatch/views/widgets/spot_map.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<ReverseBeaconService>(
      ReverseBeaconServiceImpl(reverseBeacon: ReverseBeacon()));
  getIt.registerSingleton<ConnectivityService>(
      ConnectivityServiceImpl(connectivity: Connectivity()));
  getIt.registerSingleton<GeolocationService>(GeolocationServiceImpl());
  getIt.registerSingleton<ReverseBeaconNodeService>(
      ReverseBeaconNodeServiceImpl());
  getIt.registerSingleton<MapService>(MapServiceImpl(
      reverseBeaconNodeService: getIt<ReverseBeaconNodeService>(),
      geolocationService: getIt<GeolocationService>()));
  getIt.registerSingleton<SpotList>(const SpotList());
  getIt.registerSingleton<SpotMap>(const SpotMap());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/disconnected': (context) => const DisconnectedScreen(),
      },
      title: 'Spotwatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 91, 180)),
        useMaterial3: true,
      ),
    );
  }
}
