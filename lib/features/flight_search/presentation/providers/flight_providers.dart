import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/flight_remote_data_source.dart';
import '../../data/repositories/flight_repository_impl.dart';
import '../../domain/repositories/flight_repository.dart';
import '../../domain/usecases/search_flights.dart';
import '../../domain/usecases/get_flight_details.dart';
import '../../domain/usecases/search_cities.dart';

// Data source provider
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final flightRemoteDataSourceProvider = Provider<FlightRemoteDataSource>((ref) {
  return FlightRemoteDataSourceImpl(client: ref.read(httpClientProvider));
});

// Repository provider
final flightRepositoryProvider = Provider<FlightRepository>((ref) {
  return FlightRepositoryImpl(
    remoteDataSource: ref.read(flightRemoteDataSourceProvider),
  );
});

// Use case providers
final searchFlightsUseCaseProvider = Provider<SearchFlights>((ref) {
  return SearchFlights(ref.read(flightRepositoryProvider));
});

final getFlightDetailsUseCaseProvider = Provider<GetFlightDetails>((ref) {
  return GetFlightDetails(ref.read(flightRepositoryProvider));
});

final searchCitiesUseCaseProvider = Provider<SearchCities>((ref) {
  return SearchCities(ref.read(flightRepositoryProvider));
});