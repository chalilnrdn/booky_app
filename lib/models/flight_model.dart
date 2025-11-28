class FlightModel {
  final String logo;
  final String departure;
  final String arrival;
  final String flightNo;
  final int price;

  FlightModel({
    required this.logo,
    required this.departure,
    required this.arrival,
    required this.flightNo,
    required this.price,
  });

  static List<FlightModel> dummy() => [
    FlightModel(
      logo: 'assets/images/emirates_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 100,
    ),
    FlightModel(
      logo: 'assets/images/garudaindonesia_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 234,
    ),
    FlightModel(
      logo: 'assets/images/japanairlines_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 837,
    ),
    FlightModel(
      logo: 'assets/images/qatarairways_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 211,
    ),
    FlightModel(
      logo: 'assets/images/singaporeairlines_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 670,
    ),
    FlightModel(
      logo: 'assets/images/americanairlines_logo.png',
      departure: '05:31am',
      arrival: '08:43am',
      flightNo: 'JSDN3',
      price: 739,
    ),
  ];
}
