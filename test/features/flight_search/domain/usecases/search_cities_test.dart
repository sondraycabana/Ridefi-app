import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:flight_search_app/features/flight_search/domain/entities/city.dart';
import 'package:flight_search_app/features/flight_search/domain/repositories/flight_repository.dart';
import 'package:flight_search_app/features/flight_search/domain/usecases/search_cities.dart';
import 'package:flight_search_app/core/error/failures.dart';

import 'search_cities_test.mocks.dart';

@GenerateMocks([FlightRepository])
void main() {
  late SearchCities usecase;
  late MockFlightRepository mockFlightRepository;

  setUp(() {
    mockFlightRepository = MockFlightRepository();
    usecase = SearchCities(mockFlightRepository);
  });

  const testQuery = 'lag';
  const testCities = [
    City(code: 'LOS', name: 'Lagos', country: 'Nigeria'),
  ];

  group('SearchCities', () {
    test('should get cities from the repository when search is successful', () async {
      // arrange
      when(mockFlightRepository.searchCities(testQuery))
          .thenAnswer((_) async => const Right(testCities));

      // act
      final result = await usecase(testQuery);

      // assert
      expect(result, const Right(testCities));
      verify(mockFlightRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return empty list when no cities match', () async {
      // arrange
      when(mockFlightRepository.searchCities(testQuery))
          .thenAnswer((_) async => const Right([]));

      // act
      final result = await usecase(testQuery);

      // assert
      expect(result, const Right([]));
      verify(mockFlightRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return ServerFailure when the repository call fails', () async {
      // arrange
      const testFailure = ServerFailure('Server error');
      when(mockFlightRepository.searchCities(testQuery))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testQuery);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockFlightRepository);
    });

    test('should return NetworkFailure when there is a network error', () async {
      // arrange
      const testFailure = NetworkFailure('Network error');
      when(mockFlightRepository.searchCities(testQuery))
          .thenAnswer((_) async => const Left(testFailure));

      // act
      final result = await usecase(testQuery);

      // assert
      expect(result, const Left(testFailure));
      verify(mockFlightRepository.searchCities(testQuery));
      verifyNoMoreInteractions(mockFlightRepository);
    });
  });
}