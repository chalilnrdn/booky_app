class PassengerCount {
  final int adults;
  final int children;
  final int infants;

  const PassengerCount({
    this.adults = 1,
    this.children = 0,
    this.infants = 0,
  });

  int get total => adults + children + infants;

  @override
  String toString() {
    return "$adults Adults, $children Children, $infants Infants";
  }

  PassengerCount copyWith({
    int? adults,
    int? children,
    int? infants,
  }) {
    return PassengerCount(
      adults: adults ?? this.adults,
      children: children ?? this.children,
      infants: infants ?? this.infants,
    );
  }
}