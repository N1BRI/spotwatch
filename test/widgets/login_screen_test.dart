import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/contracts/connectivity_service.dart';
import 'package:spotwatch/contracts/geolocation_service.dart';
import 'package:spotwatch/contracts/map_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_node_service.dart';
import 'package:spotwatch/contracts/reverse_beacon_service.dart';
import 'package:spotwatch/main.dart';
import 'package:spotwatch/services/connectivity_service_impl.dart';
import 'package:spotwatch/services/geolocation_service_impl.dart';
import 'package:spotwatch/services/map_service_impl.dart';
import 'package:spotwatch/services/reverse_beacon_node_service_impl.dart';
import 'package:spotwatch/services/reverse_beacon_service_impl.dart';
import 'package:spotwatch/views/login_screen.dart';
import 'package:spotwatch/views/widgets/spot_list.dart';
import 'package:spotwatch/views/widgets/spot_map.dart';

import 'mocks/reverse_beacon_service_connection_failure_mock.dart';

void registerServices() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<ReverseBeaconService>(ReverseBeaconServiceImpl(
      rollingSpotCount: 25, reverseBeacon: ReverseBeacon()));
  getIt.registerSingleton<ConnectivityService>(
      ConnectivityServiceImpl(connectivity: Connectivity()));
  getIt.registerSingleton<GeolocationService>(GeolocationServiceImpl());
  getIt.registerSingleton<ReverseBeaconNodeService>(
      ReverseBeaconNodeServiceImpl());
  getIt.registerSingleton<MapService>(MapServiceImpl(
      reverseBeaconService: getIt<ReverseBeaconService>(),
      reverseBeaconNodeService: getIt<ReverseBeaconNodeService>(),
      geolocationService: getIt<GeolocationService>()));
  getIt.registerSingleton<SpotList>(const SpotList());
  getIt.registerSingleton<SpotMap>(const SpotMap());
}

void unRegisterServices() {
  getIt.unregister<ReverseBeaconService>();
  getIt.unregister<ConnectivityService>();
  getIt.unregister<GeolocationService>();
  getIt.unregister<ReverseBeaconNodeService>();
  getIt.unregister<MapService>();
  getIt.unregister<SpotList>();
  getIt.unregister<SpotMap>();
}

void registerServicesConnFailure() {
  WidgetsFlutterBinding.ensureInitialized();
    getIt.registerSingleton<ReverseBeaconService>(
      RBConnFailureMock(rollingSpotCount: 25, reverseBeacon: ReverseBeacon()));
  getIt.registerSingleton<ConnectivityService>(
      ConnectivityServiceImpl(connectivity: Connectivity()));
  getIt.registerSingleton<GeolocationService>(GeolocationServiceImpl());
  getIt.registerSingleton<ReverseBeaconNodeService>(
      ReverseBeaconNodeServiceImpl());
  getIt.registerSingleton<MapService>(MapServiceImpl(
      reverseBeaconService: getIt<ReverseBeaconService>(),
      reverseBeaconNodeService: getIt<ReverseBeaconNodeService>(),
      geolocationService: getIt<GeolocationService>()));
  getIt.registerSingleton<SpotList>(const SpotList());
  getIt.registerSingleton<SpotMap>(const SpotMap());
}

void main() {
  testWidgets('LoginScreen initial state contains expected widgets',
      (widgetTester) async {
    registerServices();
    const widget = MaterialApp(home: LoginScreen());
    await widgetTester.pumpWidget(widget);
    expect(find.text('SPOTWATCH'), findsOneWidget);
    expect(find.byIcon(Icons.radar_sharp), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Callsign'), findsOneWidget);
    unRegisterServices();
  });

  testWidgets(
      'Start Listening button is enabled when a valid callsign is entered',
      (widgetTester) async {
    registerServices();
    const widget = MaterialApp(home: LoginScreen());
    await widgetTester.pumpWidget(widget);
    var callsignFieldFinder = find.widgetWithText(TextFormField, 'Callsign');
    await widgetTester.enterText(callsignFieldFinder, 'w1nrg');

    await widgetTester.pumpAndSettle();

    expect(
        widgetTester
            .widget<ElevatedButton>(
                find.widgetWithText(ElevatedButton, 'Start Listening'))
            .enabled,
        isTrue);
    unRegisterServices();
  });

  testWidgets(
      'Start Listening button is disabled when an invalid callsign is entered',
      (widgetTester) async {
        registerServices();
    const widget = MaterialApp(home: LoginScreen());
    await widgetTester.pumpWidget(widget);
    var callsignFieldFinder = find.widgetWithText(TextFormField, 'Callsign');
    await widgetTester.enterText(callsignFieldFinder, 'eeeeeeeeeee2');

    await widgetTester.pumpAndSettle();

    expect(
        widgetTester
            .widget<ElevatedButton>(
                find.widgetWithText(ElevatedButton, 'Start Listening'))
            .enabled,
        isFalse);
        unRegisterServices();
  });

    testWidgets(
      'Snackbar is shown when connect fails',
      (widgetTester) async {
        registerServicesConnFailure();
    const widget = MaterialApp(home: LoginScreen());
    await widgetTester.pumpWidget(widget);

    var callsignFieldFinder = find.widgetWithText(TextFormField, 'Callsign');
    await widgetTester.enterText(callsignFieldFinder, 'n1bri');
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Start Listening'));
    await widgetTester.pumpAndSettle();
    expect(find.widgetWithText(SnackBar, 'Failure to connect to telnet servers'), findsOneWidget);
    unRegisterServices();
  });

}
