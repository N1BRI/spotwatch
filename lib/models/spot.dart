import 'package:spotwatch/models/enums.dart';

class Spot{
  final String skimmerCall;
  final double frequency;  
  final String spottedCall;
  final String mode;
  final int db;
  final int wpm;
  final String time;
  final SpotType spotType;

  Spot({required this.skimmerCall, 
  required this.frequency, 
  required this.spottedCall, 
  required this.mode, 
  required this.db, 
  required this.wpm, 
  required this.spotType,
  required this.time});  

  @override String toString() {
    return '$skimmerCall heard $spottedCall on $frequency $mode type: $spotType \n @ $time @ $db db going $wpm WPM';
  }

}
