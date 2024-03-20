part of 'reverse_beacon_bloc.dart';

final class ReverseBeaconState {
  final ReverseBeaconFeed reverseBeaconFeed;
  final String callsign;
  final ReverseBeaconStatus reverseBeaconStatus;
  List<bool Function(Spot)>? filters = [];
  ReverseBeaconState(
      {required this.reverseBeaconFeed,
      this.callsign = "",
      this.reverseBeaconStatus = ReverseBeaconStatus.initial, 
      List<bool Function(Spot)>? filters
      }) : filters = filters ?? [];


  ReverseBeaconState copyWith(
      {ReverseBeaconFeed? reverseBeaconFeed,
      String? callsign,
      ReverseBeaconStatus? reverseBeaconStatus,
      List<bool Function(Spot)>? filters}) {
    return ReverseBeaconState(
        reverseBeaconFeed: reverseBeaconFeed ?? this.reverseBeaconFeed,
        callsign: callsign ?? this.callsign,
        reverseBeaconStatus: reverseBeaconStatus ?? this.reverseBeaconStatus,
        filters : filters ?? this.filters);
  }
}
