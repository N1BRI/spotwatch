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

  void testBandRejection(Band bandFilter, Band bandToReject) {
    final spot = Spot(
      skimmerCall: 'dk1dd',
      frequency: 1.0,
      band: bandToReject,
      spottedCall: 'nn1d',
      mode: Mode.ft8,
      db: 24,
      time: DateTime.now(),
      spotType: SpotType.cq,
    );

    service.addFilter(
      Filter(
          type: FilterType.band,
          label: bandFilter
              .toString()
              .split('.')[1], // Extract band name from enum
          on: (spot) => spot.band == bandFilter),
    );

    service.addSpot(spot);
    expect(service.getSpots().isEmpty, true);
  }

  test('spot is added to list when no filters', () {
    final spot = Spot(
        skimmerCall: 'dk1dd',
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
  group('[Band filter rejection tests]', () {
    test('160m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters160)) {
        testBandRejection(Band.meters160, band);
      }
    });
    test('80m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters80)) {
        testBandRejection(Band.meters80, band);
      }
    });
     test('60m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters60)) {
        testBandRejection(Band.meters60, band);
      }
    });
     test('40m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters40)) {
        testBandRejection(Band.meters40, band);
      }
    });
     test('30m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters30)) {
        testBandRejection(Band.meters30, band);
      }
    });
     test('20m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters20)) {
        testBandRejection(Band.meters20, band);
      }
    });
     test('10m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters10)) {
        testBandRejection(Band.meters10, band);
      }
    });
     test('6m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters6)) {
        testBandRejection(Band.meters6, band);
      }
    });
     test('2m filter rejects spots on any other band', () {
      for (var band
          in Band.values.where((element) => element != Band.meters2)) {
        testBandRejection(Band.meters2, band);
      }
    });
  });
  group('[Mode filter: CW] Add, Apply Filter tests', () {
    test('cw filter rejects ft8 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('cw filter rejects ft4 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft4,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('cw filter rejects rtty spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.rtty,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('cw filter rejects na spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.na,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('cw filter accepts cw spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
    });
  });

  group('[Mode filter: FT8] Add then Apply Filter tests', () {
    test('ft8 filter rejects cw spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft8 filter rejects ft4 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft4,
          db: -24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft8 filter rejects rtty spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.rtty,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft8 filter rejects na spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.na,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft8 filter accepts FT8 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
    });
  });

  group('[Mode filter: FT4] Add then Apply Filter tests', () {
    test('ft4 filter rejects cw spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT4',
        on: (spot) {
          return spot.mode == Mode.ft4;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft4 filter rejects ft8 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: -24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft4;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft4 filter rejects rtty spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.rtty,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT4',
        on: (spot) {
          return spot.mode == Mode.ft4;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft4 filter rejects na spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.na,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT4',
        on: (spot) {
          return spot.mode == Mode.ft4;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('ft4 filter accepts ft4 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft4,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT4',
        on: (spot) {
          return spot.mode == Mode.ft4;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
    });
  });

  group('[Mode filter: RTTY] Add then Apply Filter tests', () {
    test('rtty filter rejects cw spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'RTTY',
        on: (spot) {
          return spot.mode == Mode.rtty;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('rtty filter rejects ft8 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: -24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'RTTY',
        on: (spot) {
          return spot.mode == Mode.rtty;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('rtty filter rejects ft4 spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft4,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'RTTY',
        on: (spot) {
          return spot.mode == Mode.rtty;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('rtty filter rejects na spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.na,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'RTTY',
        on: (spot) {
          return spot.mode == Mode.rtty;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots().isEmpty, true);
    });

    test('rtty filter accepts rtty spot', () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.rtty,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'RTTY',
        on: (spot) {
          return spot.mode == Mode.rtty;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
    });
  });

  group('Filter removal tests', () {
    test(
        'spot with mode and callsign filters is retained when callsign filter is removed',
        () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
      final callFilter = Filter(
        type: FilterType.callsign,
        label: 'NN1D',
        on: (spot) {
          return spot.spottedCall.toUpperCase() == 'NN1D';
        },
      );
      service.addFilter(callFilter);
      expect(service.getSpots(), contains(spot));
      service.removeFilter(callFilter);
      expect(service.getSpots(), contains(spot));
    });

    test(
        'spot with band and callsign filters is retained when callsign filter is removed',
        () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.band,
        label: '30',
        on: (spot) {
          return spot.band == Band.meters30;
          ;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
      final callFilter = Filter(
        type: FilterType.callsign,
        label: 'NN1D',
        on: (spot) {
          return spot.spottedCall.toUpperCase() == 'NN1D';
        },
      );
      service.addFilter(callFilter);
      expect(service.getSpots(), contains(spot));
      service.removeFilter(callFilter);
      expect(service.getSpots(), contains(spot));
    });

    test(
        'spot with band and mode filters is retained when mode filter is removed',
        () {
      final spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.ft8,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);
      service.addFilter(Filter(
        type: FilterType.band,
        label: '30',
        on: (spot) {
          return spot.band == Band.meters30;
          ;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
      final modeFilter = Filter(
        type: FilterType.mode,
        label: 'FT8',
        on: (spot) {
          return spot.mode == Mode.ft8;
        },
      );
      service.addFilter(modeFilter);
      expect(service.getSpots(), contains(spot));
      service.removeFilter(modeFilter);
      expect(service.getSpots(), contains(spot));
    });
  });
  group('Miscellaneous Filter tests', () {
    test('callsign takes precedence over all other filters', () {
      var spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);

      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addFilter(Filter(
        type: FilterType.band,
        label: '30',
        on: (spot) {
          return spot.band == Band.meters30;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
      service.addFilter(Filter(
        type: FilterType.callsign,
        label: 'b1ffc',
        on: (spot) {
          return spot.spottedCall == 'b1ffc';
        },
      ));
      expect(service.getSpots().isEmpty, true);
    });
    test('mode match and band mismatch should reject spot', () {
      var spot = Spot(
          skimmerCall: 'dk1dd',
          frequency: 10.114,
          band: Band.meters30,
          spottedCall: 'nn1d',
          mode: Mode.cw,
          db: 24,
          time: DateTime.now(),
          spotType: SpotType.cq);

      service.addFilter(Filter(
        type: FilterType.mode,
        label: 'CW',
        on: (spot) {
          return spot.mode == Mode.cw;
        },
      ));
      service.addSpot(spot);
      expect(service.getSpots(), contains(spot));
      service.addFilter(Filter(
        type: FilterType.band,
        label: '40',
        on: (spot) {
          return spot.band == Band.meters40;
        },
      ));
      expect(service.getSpots().isEmpty, true);
    });
  });
}
