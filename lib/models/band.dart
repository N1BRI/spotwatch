
String getBandLabelByFrequency(double number) {
  switch (number) {
    case var n when n >= 1800000 && n < 2000000:
      return '160m';
    case var n when n >= 3500000 && n < 4000000:
      return '80m';
    case var n when n >= 5330500 && n < 5404000:
      return '60m'; 
    case var n when n >= 7000000 && n < 7300000:
      return '40m';
    case var n when n >= 10100000 && n < 10150000:
      return '30m';
    case var n when n >= 14000000 && n < 14350000:
      return '20m';
    case var n when n >= 18068000 && n < 18168000:
      return '17m';
    case var n when n >= 21000000 && n < 21450000:
      return '15m';
    case var n when n >= 24890000 && n < 24990000:
      return '12m';
    case var n when n >= 28000000 && n < 29700000:
      return '10m';
    case var n when n >= 50000000 && n < 54000000:
      return '6m';
    default:
      return 'No matching band found';
  }
}
