import 'package:reverse_beacon/reverse_beacon.dart';

extension BandConverter on Band {
  String getString() {
    switch (this) {
      case Band.meters160:
        return '160';
      case Band.meters80:
        return '80';
      case Band.meters60:
        return '60';
      case Band.meters40:
        return '40';
      case Band.meters30:
        return '30';
      case Band.meters20:
        return '20';
      case Band.meters17:
        return '17';
      case Band.meters15:
        return '15';
      case Band.meters12:
        return '12';
      case Band.meters10:
        return '10';
      case Band.meters6:
        return '6';
      case Band.meters2:
        return '2';
      case Band.meters125:
        return '1.25';
      case Band.centimeters70:
        return '70';
      case Band.centimeters33:
        return '33';
      case Band.centimeters23:
        return '23';
    }
  }

  Band? getEnumFromString(String value) {
    switch (value) {
      case '160':
        return Band.meters160;
      case '80':
        return Band.meters80;
      case '60':
        return Band.meters60;
      case '40':
        return Band.meters40;
      case '30':
        return Band.meters30;
      case '20':
        return Band.meters20;
      case '17':
        return Band.meters17;
      case '15':
        return Band.meters15;
      case '12':
        return Band.meters12;
      case '10':
        return Band.meters10;
      case '6':
        return Band.meters6;
      case '2':
        return Band.meters2;
      case '1.25':
        return Band.meters125;
      case '70':
        return Band.centimeters70;
      case '33':
        return Band.centimeters33;
      case '23':
        return Band.centimeters23;
      default:
        return null; // Return null for invalid strings
    }
  }
}
