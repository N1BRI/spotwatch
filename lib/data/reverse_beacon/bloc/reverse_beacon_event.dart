part of 'reverse_beacon_bloc.dart';

@immutable
sealed class ReverseBeaconEvent {
  const ReverseBeaconEvent();
}

final class ReverseBeaconConnected extends ReverseBeaconEvent{
  final String callsign;
  const ReverseBeaconConnected(this.callsign);
}

final class ReverseBeaconSpotAvailable extends ReverseBeaconEvent{
  final Spot spot;
  const ReverseBeaconSpotAvailable(this.spot);
}

final class ReverseBeaconListening extends ReverseBeaconEvent{
  final ReverseBeaconFeed feed;
  const ReverseBeaconListening(this.feed);
}

