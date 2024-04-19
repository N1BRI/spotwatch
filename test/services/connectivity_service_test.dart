import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spotwatch/services/connectivity_service_impl.dart';

import 'connectivity_service_test.mocks.dart';

@GenerateMocks([
  Connectivity,
], customMocks: [
  MockSpec<Connectivity>(
    as: #MockConnectivityPlus,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockConnectivity mockConnectivity;
  late ConnectivityServiceImpl service;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockConnectivity = MockConnectivity();
    service = ConnectivityServiceImpl(connectivity: mockConnectivity);
  });

  group('ConnectivityServiceImpl Tests', () {
    test('should initially have no connection', () {
      expect(service.hasInternetConnection(), false);
    });
  });

    test('should detect internet connection on change', () async {
      // Simulate connectivity change to Wifi
      Iterable<List<ConnectivityResult>> connectivityResults =
          Iterable.generate(1, (index) => [ConnectivityResult.none]);
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value([ConnectivityResult.wifi]));
      when(mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => Stream.fromIterable(connectivityResults));

      service.connectionStatusChanged([ConnectivityResult.wifi]);

      await Future.delayed(const Duration(milliseconds: 100)); // Wait for listener

      expect(service.hasInternetConnection(), true);
    });
}
