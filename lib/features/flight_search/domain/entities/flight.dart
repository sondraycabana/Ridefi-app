import 'package:equatable/equatable.dart';

class Flight extends Equatable {
  final String id;
  final String flightNumber;
  final String airline;
  final String? airlineLogoUrl;
  final String aircraft;
  final String departureCity;
  final String arrivalCity;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String currency;
  final Duration duration;
  final int stops;
  final List<String> stopCities;
  final bool isDirect;
  final String seatClass;
  final int checkedBags;
  final int carryOnBags;
  final String cancellationPolicy;
  final String refundPolicy;
  final bool hasWiFi;
  final bool hasMeals;
  final bool hasEntertainment;

  const Flight({
    required this.id,
    required this.flightNumber,
    required this.airline,
    this.airlineLogoUrl,
    required this.aircraft,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.currency,
    required this.duration,
    required this.stops,
    required this.stopCities,
    required this.isDirect,
    required this.seatClass,
    required this.checkedBags,
    required this.carryOnBags,
    required this.cancellationPolicy,
    required this.refundPolicy,
    required this.hasWiFi,
    required this.hasMeals,
    required this.hasEntertainment,
  });

  @override
  List<Object?> get props => [
        id,
        flightNumber,
        airline,
        airlineLogoUrl,
        aircraft,
        departureCity,
        arrivalCity,
        departureAirport,
        arrivalAirport,
        departureTime,
        arrivalTime,
        price,
        currency,
        duration,
        stops,
        stopCities,
        isDirect,
        seatClass,
        checkedBags,
        carryOnBags,
        cancellationPolicy,
        refundPolicy,
        hasWiFi,
        hasMeals,
        hasEntertainment,
      ];
}