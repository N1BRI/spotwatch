import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:circular_buffer/circular_buffer.dart';
import 'package:spotwatch/models/spot.dart';

class ReverseBeaconFeed {
  CircularBuffer<Spot> beaconSpots = CircularBuffer<Spot>(8);
  Socket? socket;
  StreamSubscription<Spot>? subscription;
  StreamController<Spot> controller = StreamController();

  Future<void> connect(
      {required callsign,
      void Function()? onDoneCallback,
      void Function()? onErrorCallBack}) async {
    socket = await Socket.connect("telnet.reversebeacon.net", 7000,
        timeout: const Duration(seconds: 25));

    socket?.listen(onDone: onDoneCallback, onError: onErrorCallBack,
        (List<int> event) {
      List<String> spots = utf8
          .decode(event)
          .split('\n')
          .where((String s) => s.isNotEmpty)
          .toList();

      if (spots[0] == "Please enter your call: ") {
        socket?.add(utf8.encode('$callsign\r\n'));
      } else {
        spots = spots.where((e) => e.startsWith('DX')).toList();
        List<String> s = <String>[];
        for (int i = 0; i < spots.length; i++) {
          s = spots[i].split(" ").where((e) => e.isNotEmpty).toList();

          if (s.isNotEmpty) {
            controller.add(Spot(
                skimmerCall: s[2],
                frequency: double.tryParse(s[3]) ?? 0,
                spottedCall: s[4],
                mode: s[5],
                db: int.tryParse(s[6]) ?? 0,
                wpm: int.tryParse(s[8]) ?? 0,
                time: s.last));
          }
        }
      }
    });
  }
}
