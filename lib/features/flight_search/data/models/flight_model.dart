import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/flight.dart';

@JsonSerializable()
class FlightModel extends Flight {
  const FlightModel({
    required super.id,
    required super.flightNumber,
    required super.airline,
    super.airlineLogoUrl,
    required super.aircraft,
    required super.departureCity,
    required super.arrivalCity,
    required super.departureAirport,
    required super.arrivalAirport,
    required super.departureTime,
    required super.arrivalTime,
    required super.price,
    required super.currency,
    required super.duration,
    required super.stops,
    required super.stopCities,
    required super.isDirect,
    required super.seatClass,
    required super.checkedBags,
    required super.carryOnBags,
    required super.cancellationPolicy,
    required super.refundPolicy,
    required super.hasWiFi,
    required super.hasMeals,
    required super.hasEntertainment,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) => FlightModel(
        id: json['id'] as String,
        flightNumber: json['flightNumber'] as String,
        airline: json['airline'] as String,
        airlineLogoUrl: json['airlineLogoUrl'] as String?,
        aircraft: json['aircraft'] as String,
        departureCity: json['departureCity'] as String,
        arrivalCity: json['arrivalCity'] as String,
        departureAirport: json['departureAirport'] as String,
        arrivalAirport: json['arrivalAirport'] as String,
        departureTime: DateTime.parse(json['departureTime'] as String),
        arrivalTime: DateTime.parse(json['arrivalTime'] as String),
        price: (json['price'] as num).toDouble(),
        currency: json['currency'] as String,
        duration: Duration(
          microseconds: json['duration'] as int,
        ),
        stops: json['stops'] as int,
        stopCities: (json['stopCities'] as List<dynamic>).cast<String>(),
        isDirect: json['isDirect'] as bool,
        seatClass: json['seatClass'] as String,
        checkedBags: json['checkedBags'] as int,
        carryOnBags: json['carryOnBags'] as int,
        cancellationPolicy: json['cancellationPolicy'] as String,
        refundPolicy: json['refundPolicy'] as String,
        hasWiFi: json['hasWiFi'] as bool,
        hasMeals: json['hasMeals'] as bool,
        hasEntertainment: json['hasEntertainment'] as bool,
      );

  // Factory for Aviation Stack API flight response
  factory FlightModel.fromAviationStack(Map<String, dynamic> json) {
    final departure = json['departure'] as Map<String, dynamic>? ?? {};
    final arrival = json['arrival'] as Map<String, dynamic>? ?? {};
    final airline = json['airline'] as Map<String, dynamic>? ?? {};
    final flight = json['flight'] as Map<String, dynamic>? ?? {};
    
    // Parse times - use scheduled if available, otherwise estimated
    DateTime? departureTime;
    DateTime? arrivalTime;
    
    try {
      String? depTimeStr = departure['scheduled'] as String? ?? departure['estimated'] as String?;
      String? arrTimeStr = arrival['scheduled'] as String? ?? arrival['estimated'] as String?;
      
      if (depTimeStr != null) departureTime = DateTime.parse(depTimeStr);
      if (arrTimeStr != null) arrivalTime = DateTime.parse(arrTimeStr);
    } catch (e) {
      // Fallback to current time if parsing fails
      departureTime = DateTime.now();
      arrivalTime = DateTime.now().add(const Duration(hours: 2));
    }
    
    // Calculate duration
    Duration duration = arrivalTime != null && departureTime != null 
        ? arrivalTime.difference(departureTime) 
        : const Duration(hours: 2);
    
    return FlightModel(
      id: '${flight['iata'] ?? ''}_${json['flight_date'] ?? ''}',
      flightNumber: flight['iata'] as String? ?? flight['number'] as String? ?? 'N/A',
      airline: airline['name'] as String? ?? 'Unknown Airline',
      airlineLogoUrl: null,
      aircraft: flight['codeshared']?['airline']?['name'] as String? ?? 'Unknown Aircraft',
      departureCity: departure['airport'] as String? ?? 'Unknown',
      arrivalCity: arrival['airport'] as String? ?? 'Unknown',
      departureAirport: departure['iata'] as String? ?? departure['icao'] as String? ?? '',
      arrivalAirport: arrival['iata'] as String? ?? arrival['icao'] as String? ?? '',
      departureTime: departureTime ?? DateTime.now(),
      arrivalTime: arrivalTime ?? DateTime.now().add(const Duration(hours: 2)),
      price: 0.0, // Aviation Stack API doesn't provide pricing
      currency: 'USD',
      duration: duration,
      stops: 0, // Assume direct flights for now
      stopCities: const [],
      isDirect: true,
      seatClass: 'Economy',
      checkedBags: 1,
      carryOnBags: 1,
      cancellationPolicy: 'Contact airline for cancellation policy',
      refundPolicy: 'Contact airline for refund policy',
      hasWiFi: false,
      hasMeals: false,
      hasEntertainment: false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'flightNumber': flightNumber,
        'airline': airline,
        'airlineLogoUrl': airlineLogoUrl,
        'aircraft': aircraft,
        'departureCity': departureCity,
        'arrivalCity': arrivalCity,
        'departureAirport': departureAirport,
        'arrivalAirport': arrivalAirport,
        'departureTime': departureTime.toIso8601String(),
        'arrivalTime': arrivalTime.toIso8601String(),
        'price': price,
        'currency': currency,
        'duration': duration.inMicroseconds,
        'stops': stops,
        'stopCities': stopCities,
        'isDirect': isDirect,
        'seatClass': seatClass,
        'checkedBags': checkedBags,
        'carryOnBags': carryOnBags,
        'cancellationPolicy': cancellationPolicy,
        'refundPolicy': refundPolicy,
        'hasWiFi': hasWiFi,
        'hasMeals': hasMeals,
        'hasEntertainment': hasEntertainment,
      };

  static FlightModel fromEntity(Flight flight) {
    return FlightModel(
      id: flight.id,
      flightNumber: flight.flightNumber,
      airline: flight.airline,
      airlineLogoUrl: flight.airlineLogoUrl,
      aircraft: flight.aircraft,
      departureCity: flight.departureCity,
      arrivalCity: flight.arrivalCity,
      departureAirport: flight.departureAirport,
      arrivalAirport: flight.arrivalAirport,
      departureTime: flight.departureTime,
      arrivalTime: flight.arrivalTime,
      price: flight.price,
      currency: flight.currency,
      duration: flight.duration,
      stops: flight.stops,
      stopCities: flight.stopCities,
      isDirect: flight.isDirect,
      seatClass: flight.seatClass,
      checkedBags: flight.checkedBags,
      carryOnBags: flight.carryOnBags,
      cancellationPolicy: flight.cancellationPolicy,
      refundPolicy: flight.refundPolicy,
      hasWiFi: flight.hasWiFi,
      hasMeals: flight.hasMeals,
      hasEntertainment: flight.hasEntertainment,
    );
  }
}