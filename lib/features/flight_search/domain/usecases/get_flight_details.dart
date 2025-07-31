import 'package:dartz/dartz.dart';
import '../entities/flight.dart';
import '../repositories/flight_repository.dart';
import '../../../../core/error/failures.dart';

class GetFlightDetails {
  final FlightRepository repository;

  GetFlightDetails(this.repository);

  Future<Either<Failure, Flight>> call(String flightId) async {
    return await repository.getFlightDetails(flightId);
  }
}