import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flight_search_app/features/flight_search/domain/entities/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/entities/flight_search_params.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repository.dart';
import 'package:flight_search_app/features/flight_search/domain/usecases/search_flights.dart';
import 'package:flight_search_app/core/error/failures.dart';

import 'search_flights_test.mocks.dart';

@GenerateMocks([FlightRepository])
void main() {
  late SearchFlights usecase;
  late MockFlightRepository mockFlightRepository;

  setUp(() {
    mockFlightRepository = MockFlightRepository();
    usecase = SearchFlights(mockFlightRepository);
  });

  final testParams = FlightSearchParams(
    departureCity: 'Lagos',
    arrivalCity: 'Abuja',
    departureDate: DateTime(2024, 12, 25),
  );

  final testFlights = [
    Flight(
      id: '1',
      flightNumber: 'AA2351',
      airline: 'Arik Air',
      aircraft: 'Boeing 737',
      departureCity: 'Lagos',
      arrivalCity: 'Abuja',
      departureAirport: 'LOS',
      arrivalAirport: 'ABV',
      departureTime: DateTime(2024, 12, 25, 8, 0),
      arrivalTime: DateTime(2024, 12, 25, 9, 45),
      price: 45000.0,
      currency: 'NGN',
      duration: const Duration(hours: 1, minutes: 45),
      stops: 0,
      stopCities: [],
      isDirect: true,
    ),
  ];

  group('SearchFlights', () {
    test('should get flights from the repository when search is successful', () async {
      // arrange
      when(mockFlightRepository.searchFlights(testParams))
          .thenAnswer((_) async => Right(testFlights));

      // act
      final result = await usecase(testParams);

      // assert
      expect(result, Right(testFlights));
      verify(mockFlightRepository.searchFlights(testParams));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return ServerFailure when the repository call fails', () async {
      // arrange
      const testFailure = ServerFailure('Server error');
      when(mockFlightRepository.searchFlights(testParams))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testParams);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.searchFlights(testParams));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return NetworkFailure when there is a network error', () async {
      // arrange
      const testFailure = NetworkFailure('Network error');
      when(mockFlightRepository.searchFlights(testParams))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testParams);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.searchFlights(testParams));
      verifyNoMoreInteractions(mockFlightRepository);
    });
  });
}