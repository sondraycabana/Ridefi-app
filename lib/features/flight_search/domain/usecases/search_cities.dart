import 'package:dartz/dartz.dart';
import '../entities/city.dart';
import '../repositories/flight_repository.dart';
import '../../../../core/error/failures.dart';

class SearchCities {
  final FlightRepository repository;

  SearchCities(this.repository);

  Future<Either<Failure, List<City>>> call(String query) async {
    return await repository.searchCities(query);
  }
}