import 'package:dartz/dartz.dart';
import '../../domain/entities/flight.dart';
import '../../domain/entities/flight_search_params.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/flight_repository.dart';
import '../datasources/flight_remote_data_source.dart';
import '../../../../core/error/failures.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Flight>>> searchFlights(
      FlightSearchParams params) async {
    try {
      final flights = await remoteDataSource.searchFlights(params);
      return Right(flights);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Flight>> getFlightDetails(String flightId) async {
    try {
      final flight = await remoteDataSource.getFlightDetails(flightId);
      return Right(flight);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final cities = await remoteDataSource.getCities();
      return Right(cities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<City>>> searchCities(String query) async {
    try {
      final cities = await remoteDataSource.searchCities(query);
      return Right(cities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}