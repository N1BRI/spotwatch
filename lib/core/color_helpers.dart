import 'package:flutter/material.dart';
import 'package:reverse_beacon/reverse_beacon.dart';

Color spotModeToColor(Mode mode) {
  switch (mode) {
    case Mode.cw:
      return const Color(0xffc85c4f);
    case Mode.ft8:
      return const Color(0xff40568d);
    case Mode.ft4:
      return const Color(0xff04a791);
    case Mode.rtty:
      return const Color(0xffc85c4f);
    case Mode.na:
      return Colors.transparent;
  }
}

Color spotBandToColor(Band? band) {
  if(band == null){
    return Colors.black;
  }
  switch (band) {
    case Band.meters160:
      return const Color(0xffc85c4f); // Dark red
    case Band.meters80:
      return const Color(0xffeb9486); // Lighter red
    case Band.meters60:
      return const Color(0xfff3de8a); // Light orange
    case Band.meters40:
      return const Color.fromARGB(255, 243, 178, 33); // Orange
    case Band.meters30:
      return const Color.fromARGB(255, 255, 204, 0); // Yellow
    case Band.meters20:
      return const Color(0xff2892d7); // Light blue
    case Band.meters17:
      return const Color.fromARGB(255, 102, 179, 221); // Teal blue
    case Band.meters15:
      return const Color.fromARGB(255, 50, 47, 231); // Dark blue
    case Band.meters12:
      return const Color(0xff04e762); // Teal
    case Band.meters10:
      return const Color.fromARGB(255, 85, 139, 178); // Dark blue-green
    case Band.meters6:
      return const Color.fromARGB(255, 129, 255, 116); // Light green
    case Band.meters2:
      return const Color.fromARGB(255, 228, 183, 195); // Light pink
    case Band.meters125:
      return const Color.fromARGB(255, 138, 223, 223); // Light blue-green
    case Band.centimeters70:
      return const Color(0xffeae0d5); // Light gray
    case Band.centimeters33:
      return const Color(0xfff6f0e6); // Lighter gray
    case Band.centimeters23:
      return const Color(0xfff9f7f6); // Very light gray
    default:
      return Colors.grey; // Handle unknown bands
  }
}




