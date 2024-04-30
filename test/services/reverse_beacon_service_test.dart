import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/models/filter.dart';
import 'package:spotwatch/services/reverse_beacon_service_impl.dart';

import 'reverse_beacon_service_test.mocks.dart';

@GenerateMocks([
  ReverseBeacon,
], customMocks: [
  MockSpec<ReverseBeacon>(
    as: #MockRBeacon,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late ReverseBeaconServiceImpl service;

  setUp(() {
    service = ReverseBeaconServiceImpl(reverseBeacon: MockRBeacon());
  });

  test('adds spot to list when no filters', () {
    final spot = CWSpot(
        skimmerCall: 'dk1dd',
        wpm: 16,
        frequency: 10.114,
        band: Band.meters30,
        spottedCall: 'nn1d',
        mode: Mode.cw,
        db: 24,
        time: DateTime.now(),
        spotType: SpotType.cq);
    service.addSpot(spot);
    expect(service.getSpots(), contains(spot));
  });

  test(
      'cw spot with 16 wpm not added to list when filter for 25+ filter added to filters',
      () {
    final spot = CWSpot(
        skimmerCall: 'dk1dd',
        wpm: 16,
        frequency: 10.114,
        band: Band.meters30,
        spottedCall: 'nn1d',
        mode: Mode.cw,
        db: 24,
        time: DateTime.now(),
        spotType: SpotType.cq);
    service.addFilter(Filter(
      type: FilterType.other,
      label: '25+ WPM',
      on: (spot) {
        var s = spot as CWSpot;
        return s.wpm >= 25;
      },
    ));
    service.addSpot(spot);
    expect(service.getSpots().isEmpty, true);
  });

  test(
      'cw spot with 25 wpm is added to list when filter for 25+ filter added to filters',
      () {
    final spot = CWSpot(
        skimmerCall: 'dk1dd',
        wpm: 25,
        frequency: 10.114,
        band: Band.meters30,
        spottedCall: 'nn1d',
        mode: Mode.cw,
        db: 24,
        time: DateTime.now(),
        spotType: SpotType.cq);
    service.addFilter(Filter(
      type: FilterType.other,
      label: '25+ WPM',
      on: (spot) {
        var s = spot as CWSpot;
        return s.wpm >= 25;
      },
    ));
    service.addSpot(spot);
    expect(service.getSpots(), contains(spot));
  });
}
