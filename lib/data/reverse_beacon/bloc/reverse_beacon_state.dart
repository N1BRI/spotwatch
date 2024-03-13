part of 'reverse_beacon_bloc.dart';

@immutable
sealed class ReverseBeaconState extends Equatable {
  final ReverseBeaconFeed reverseBeaconFeed;
  final String callsign;
  const ReverseBeaconState(this.reverseBeaconFeed, this.callsign);
  @override
  List<Object> get props => [callsign];
}


final class ReverseBeaconInitial extends ReverseBeaconState {
  const ReverseBeaconInitial(super.reverseBeaconFeed, super.callsign);

}

final class ReverseBeaconUpdated extends ReverseBeaconState {
  const ReverseBeaconUpdated(super.reverseBeaconFeed, super.callsign); 

}

final class ReverseBeaconListening extends ReverseBeaconState {
  const ReverseBeaconListening(super.reverseBeaconFeed, super.callsign); 

}


