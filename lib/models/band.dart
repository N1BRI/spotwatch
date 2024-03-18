class Band{
  final double top;
  final double bottom;
  final String label;

  Band({required this.top, required this.bottom, required this.label});

}

List<Band> getBands(){
  return   [
    Band(top: 630000, bottom: 590000, label: '630m'),
    Band(top: 2000000, bottom: 1838000, label: '160m'),
    Band(top: 4000000, bottom: 3500000, label: '80m'),
    Band(top: 5100000, bottom: 5250000, label: '60m'),
    Band(top: 7300000, bottom: 7000000, label: '40m'),
    Band(top: 10150000, bottom: 10135000, label: '30m'),
    Band(top: 14350000, bottom: 14000000, label: '20m'),
    Band(top: 18168000, bottom: 18068000, label: '17m'),
    Band(top: 21450000, bottom: 21000000, label: '15m'),
    Band(top: 24915000, bottom: 24890000, label: '12m'),
    Band(top: 28268000, bottom: 28000000, label: '10m'),
    Band(top: 54200000, bottom: 50200000, label: '6m'),
    Band(top: 70500000, bottom: 68700000, label: '4m'),
    Band(top: 148000000, bottom: 144000000, label: '2m'),
  ];
}