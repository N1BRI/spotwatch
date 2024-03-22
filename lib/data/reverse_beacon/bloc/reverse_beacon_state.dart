part of 'reverse_beacon_bloc.dart';

final class ReverseBeaconState {
  final ReverseBeaconFeed reverseBeaconFeed;
  String callsign;
  final ReverseBeaconStatus reverseBeaconStatus;
  List<Filter>? filters = [];
  ReverseBeaconState(
      {required this.reverseBeaconFeed,
      this.callsign = "",
      this.reverseBeaconStatus = ReverseBeaconStatus.initial, 
      List<Filter>? filters
      }) : filters = filters ?? [];


  ReverseBeaconState copyWith(
      {ReverseBeaconFeed? reverseBeaconFeed,
      String? callsign,
      ReverseBeaconStatus? reverseBeaconStatus,
      List<Filter>? filters}) {
    return ReverseBeaconState(
        reverseBeaconFeed: reverseBeaconFeed ?? this.reverseBeaconFeed,
        callsign: callsign ?? this.callsign,
        reverseBeaconStatus: reverseBeaconStatus ?? this.reverseBeaconStatus,
        filters : filters ?? this.filters);
  }
}
