class Car {
  final int id;
  final String carNumber;
  final String chargingType;

  Car({
    required this.id,
    required this.carNumber,
    required this.chargingType,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? 0,
      carNumber: json['car_number'] ?? '',
      chargingType: json['charging_type'] ?? '',
    );
  }
}