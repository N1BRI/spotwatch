import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotwatch/models/reverse_beacon_feed.dart';
import 'package:spotwatch/models/enums.dart';
import 'package:spotwatch/models/spot.dart';
part 'reverse_beacon_event.dart';
part 'reverse_beacon_state.dart';

class ReverseBeaconBloc extends Bloc<ReverseBeaconEvent, ReverseBeaconState> {
  ReverseBeaconBloc(ReverseBeaconFeed feed) : super(ReverseBeaconState(reverseBeaconFeed: feed)) {
    on<ReverseBeaconConnected>((event, emit) async {
      await state.reverseBeaconFeed.connect(callsign: event.callsign);

      state.reverseBeaconFeed.subscription = state.reverseBeaconFeed.controller.stream.listen((spot) {
        add(ReverseBeaconSpotAvailable(spot));
      });
    });
    
    on<ReverseBeaconSpotAvailable>(
      (event, emit) {
        state.reverseBeaconFeed.beaconSpots.add(event.spot);
        emit(state.copyWith(callsign: state.callsign,
        reverseBeaconFeed: state.reverseBeaconFeed,
        reverseBeaconStatus: ReverseBeaconStatus.updated ));
      },
    );

    on<ReverseBeaconListening>((event, emit) {
      emit(state.copyWith(callsign: state.callsign,
        reverseBeaconFeed: state.reverseBeaconFeed,
        reverseBeaconStatus: ReverseBeaconStatus.listening ));
    },);

     on<ReverseBeaconPaused>((event, emit) {
      state.reverseBeaconFeed.subscription?.pause();
      emit(state.copyWith(callsign: state.callsign,
        reverseBeaconFeed: state.reverseBeaconFeed,
        reverseBeaconStatus: ReverseBeaconStatus.paused ));
    },);

    on<ReverseBeaconResumed>((event, emit) {
      state.reverseBeaconFeed.subscription?.resume();
      emit(state.copyWith(callsign: state.callsign,
        reverseBeaconFeed: state.reverseBeaconFeed,
        reverseBeaconStatus: ReverseBeaconStatus.listening ));
    },);
    

  }
}