import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:spotwatch/core/color_helpers.dart';

class ModeBadge extends StatelessWidget {
  const ModeBadge({Key? key, required this.spotMode}) : super(key: key);
  final Mode spotMode;
  @override
  Widget build(BuildContext context) {
    var text = '';
    Color bg = spotModeToColor(spotMode);
    switch (spotMode) {
      case Mode.cw:
        text = 'CW';
      case Mode.ft8:
        text = 'FT8';
      case Mode.ft4:
        text = 'FT4';
      case Mode.rtty:
        text = 'RTTY';
      case Mode.na:
        return Container();
    }
    return Container(
      width: 45,
      height: 30,
      decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.all(
            Radius.elliptical(3, 3),
          )),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
