import 'package:equatable/equatable.dart';

class FlightSearchParams extends Equatable {
  final String departureCity;
  final String arrivalCity;
  final DateTime departureDate;
  final DateTime? returnDate;
  final int passengers;
  final String tripType; // "one-way" or "round-trip"

  const FlightSearchParams({
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    this.returnDate,
    this.passengers = 1,
    this.tripType = "one-way",
  });

  @override
  List<Object?> get props => [
        departureCity,
        arrivalCity,
        departureDate,
        returnDate,
        passengers,
        tripType,
      ];
}