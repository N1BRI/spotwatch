part of 'reverse_beacon_bloc.dart';

final class ReverseBeaconState extends Equatable {
  final ReverseBeaconFeed reverseBeaconFeed;
  final String callsign;
  final ReverseBeaconStatus reverseBeaconStatus;
  const ReverseBeaconState(
      {required this.reverseBeaconFeed,
      this.callsign = "",
      this.reverseBeaconStatus = ReverseBeaconStatus.initial});

  @override
  List<Object> get props => [callsign, reverseBeaconStatus, reverseBeaconFeed];

  ReverseBeaconState copyWith(
      {ReverseBeaconFeed? reverseBeaconFeed,
      String? callsign,
      ReverseBeaconStatus? reverseBeaconStatus}) {
    return ReverseBeaconState(
        reverseBeaconFeed: reverseBeaconFeed ?? this.reverseBeaconFeed,
        callsign: callsign ?? this.callsign,
        reverseBeaconStatus: reverseBeaconStatus ?? this.reverseBeaconStatus);
  }
}
