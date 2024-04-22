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

Color spotBandToColor(Band band) {
  switch (band) {
    case Band.meters160:
      return const Color(0xffc85c4f);
    case Band.meters80:
      return const Color(0xffeb9486);
    case Band.meters60:
      return const Color(0xfff3de8a);
    case Band.meters40:
      return const Color(0xffff6542);
    case Band.meters30:
      return const Color(0xff97a7b3);
    case Band.meters20:
      return const Color(0xff2892d7);
    case Band.meters17:
      return const Color(0xff519e8a);
    case Band.meters15:
      return const Color(0xffffd3ba);
    case Band.meters12:
      return const Color(0xff04e762);
    case Band.meters10:
      return const Color(0xff8bbeb2);
    case Band.meters6:
      return const Color(0xffcaac4f);
    case Band.meters2:
      return const Color(0xffffafc5);
    case Band.meters125:
      return const Color(0xff553e4e);
    case Band.centimeters70:
      return const Color(0xffeae0d5);
    case Band.centimeters33:
      return const Color(0xfff694c1);
    case Band.centimeters23:
      return const Color(0xffff312e);
  }
}
