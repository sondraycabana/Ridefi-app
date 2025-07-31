import 'package:dartz/dartz.dart';
import '../entities/flight.dart';
import '../entities/flight_search_params.dart';
import '../repositories/flight_repository.dart';
import '../../../../core/error/failures.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<Either<Failure, List<Flight>>> call(FlightSearchParams params) async {
    return await repository.searchFlights(params);
  }
}