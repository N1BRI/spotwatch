import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotwatch/data/reverse_beacon/reverse_beacon_feed.dart';
import 'package:spotwatch/models/spot.dart';
part 'reverse_beacon_event.dart';
part 'reverse_beacon_state.dart';

class ReverseBeaconBloc extends Bloc<ReverseBeaconEvent, ReverseBeaconState> {
  ReverseBeaconBloc(ReverseBeaconFeed feed) : super(ReverseBeaconInitial(feed, '')) {
    on<ReverseBeaconConnected>((event, emit) async {
      await state.reverseBeaconFeed.connect(callsign: event.callsign);

      state.reverseBeaconFeed.subscription = state.reverseBeaconFeed.controller.stream.listen((spot) {
        add(ReverseBeaconSpotAvailable(spot));
      });
    });
    
    on<ReverseBeaconSpotAvailable>(
      (event, emit) {
        state.reverseBeaconFeed.beaconSpots.add(event.spot);
        emit(ReverseBeaconUpdated(state.reverseBeaconFeed, state.callsign));
      },
    );

    on<ReverseBeaconWaiting>((event, emit) {
      emit(ReverseBeaconListening(state.reverseBeaconFeed, state.callsign));
    },);
  }
}