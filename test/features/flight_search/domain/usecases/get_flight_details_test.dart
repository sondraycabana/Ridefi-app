import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flight_search_app/features/flight_search/domain/entities/flight.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repository.dart';
import 'package:flight_search_app/features/flight_search/domain/usecases/get_flight_details.dart';
import 'package:flight_search_app/core/error/failures.dart';

import 'get_flight_details_test.mocks.dart';

@GenerateMocks([FlightRepository])
void main() {
  late GetFlightDetails usecase;
  late MockFlightRepository mockFlightRepository;

  setUp(() {
    mockFlightRepository = MockFlightRepository();
    usecase = GetFlightDetails(mockFlightRepository);
  });

  const testFlightId = '1';
  final testFlight = Flight(
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
  );

  group('GetFlightDetails', () {
    test('should get flight details from the repository when successful', () async {
      // arrange
      when(mockFlightRepository.getFlightDetails(testFlightId))
          .thenAnswer((_) async => Right(testFlight));

      // act
      final result = await usecase(testFlightId);

      // assert
      expect(result, Right(testFlight));
      verify(mockFlightRepository.getFlightDetails(testFlightId));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return ServerFailure when the repository call fails', () async {
      // arrange
      const testFailure = ServerFailure('Flight not found');
      when(mockFlightRepository.getFlightDetails(testFlightId))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testFlightId);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.getFlightDetails(testFlightId));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return NetworkFailure when there is a network error', () async {
      // arrange
      const testFailure = NetworkFailure('Network error');
      when(mockFlightRepository.getFlightDetails(testFlightId))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testFlightId);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.getFlightDetails(testFlightId));
      verifyNoMoreInteractions(mockFlightRepository);
    });
  });
}