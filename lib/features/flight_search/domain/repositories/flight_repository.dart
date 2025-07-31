import 'package:dartz/dartz.dart';
import '../../domain/entities/flight.dart';
import '../../domain/entities/flight_search_params.dart';
import '../../domain/entities/city.dart';
import '../../../../core/error/failures.dart';

abstract class FlightRepository {
  Future<Either<Failure, List<Flight>>> searchFlights(FlightSearchParams params);
  Future<Either<Failure, Flight>> getFlightDetails(String flightId);
  Future<Either<Failure, List<City>>> getCities();
  Future<Either<Failure, List<City>>> searchCities(String query);
}