import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/flight.dart';
import '../../domain/entities/flight_search_params.dart';
import '../../domain/entities/flight_filters.dart';
import '../../domain/entities/city.dart';
import 'flight_providers.dart';

part 'flight_search_notifier.freezed.dart';
part 'flight_search_notifier.g.dart';

// Flight search state
enum FlightSearchStatus { initial, loading, success, error }

@freezed
class FlightSearchState with _$FlightSearchState {
  const factory FlightSearchState({
    @Default(FlightSearchStatus.initial) FlightSearchStatus status,
    @Default([]) List<Flight> flights,
    @Default([]) List<Flight> filteredFlights,
    String? errorMessage,
    FlightSearchParams? lastSearchParams,
    @Default(FlightFilters()) FlightFilters filters,
  }) = _FlightSearchState;

  const FlightSearchState._();

  List<Flight> get displayFlights => filteredFlights.isNotEmpty || filters.hasActiveFilters ? filteredFlights : flights;
}

@riverpod
class FlightSearch extends _$FlightSearch {
  @override
  FlightSearchState build() {
    return const FlightSearchState();
  }

  Future<void> searchFlights(FlightSearchParams params) async {
    final searchFlights = ref.read(searchFlightsUseCaseProvider);
    
    state = state.copyWith(
      status: FlightSearchStatus.loading,
      errorMessage: null,
    );

    final result = await searchFlights(params);
    
    result.fold(
      (failure) => state = state.copyWith(
        status: FlightSearchStatus.error,
        errorMessage: failure.toString(),
      ),
      (flights) {
        state = state.copyWith(
          status: FlightSearchStatus.success,
          flights: flights,
          lastSearchParams: params,
        );
        _applyFilters();
      },
    );
  }

  void clearResults() {
    state = const FlightSearchState();
  }

  void updateFilters(FlightFilters filters) {
    state = state.copyWith(filters: filters);
    _applyFilters();
  }

  void clearFilters() {
    state = state.copyWith(
      filters: const FlightFilters(),
      filteredFlights: [],
    );
  }

  void _applyFilters() {
    if (!state.filters.hasActiveFilters) {
      state = state.copyWith(filteredFlights: []);
      return;
    }

    final filtered = state.flights.where((flight) {
      // Price filter
      if (state.filters.minPrice != null && flight.price < state.filters.minPrice!) {
        return false;
      }
      if (state.filters.maxPrice != null && flight.price > state.filters.maxPrice!) {
        return false;
      }

      // Airline filter
      if (state.filters.selectedAirlines.isNotEmpty &&
          !state.filters.selectedAirlines.contains(flight.airline)) {
        return false;
      }

      // Seat class filter
      if (state.filters.selectedSeatClasses.isNotEmpty &&
          !state.filters.selectedSeatClasses.contains(flight.seatClass)) {
        return false;
      }

      // Direct flights filter
      if (state.filters.isDirect == true && !flight.isDirect) {
        return false;
      }

      // Max stops filter
      if (state.filters.maxStops != null && flight.stops > state.filters.maxStops!) {
        return false;
      }

      // Departure time filter
      if (state.filters.selectedDepartureTimeRanges.isNotEmpty) {
        final departureHour = flight.departureTime.hour;
        bool matchesTimeRange = false;
        
        for (final rangeLabel in state.filters.selectedDepartureTimeRanges) {
          final timeRange = TimeRange.departureTimeRanges.firstWhere(
            (tr) => tr.label == rangeLabel,
          );
          if (departureHour >= timeRange.startHour && 
              (timeRange.endHour == 24 ? departureHour < 24 : departureHour < timeRange.endHour)) {
            matchesTimeRange = true;
            break;
          }
        }
        
        if (!matchesTimeRange) return false;
      }

      // Arrival time filter
      if (state.filters.selectedArrivalTimeRanges.isNotEmpty) {
        final arrivalHour = flight.arrivalTime.hour;
        bool matchesTimeRange = false;
        
        for (final rangeLabel in state.filters.selectedArrivalTimeRanges) {
          final timeRange = TimeRange.arrivalTimeRanges.firstWhere(
            (tr) => tr.label == rangeLabel,
          );
          if (arrivalHour >= timeRange.startHour && 
              (timeRange.endHour == 24 ? arrivalHour < 24 : arrivalHour < timeRange.endHour)) {
            matchesTimeRange = true;
            break;
          }
        }
        
        if (!matchesTimeRange) return false;
      }

      return true;
    }).toList();

    state = state.copyWith(filteredFlights: filtered);
  }
}

// Cities search state
enum CitiesSearchStatus { initial, loading, success, error }

@freezed
class CitiesSearchState with _$CitiesSearchState {
  const factory CitiesSearchState({
    @Default(CitiesSearchStatus.initial) CitiesSearchStatus status,
    @Default([]) List<City> cities,
    String? errorMessage,
  }) = _CitiesSearchState;
}

@riverpod
class CitiesSearch extends _$CitiesSearch {
  @override
  CitiesSearchState build() {
    return const CitiesSearchState();
  }

  Future<void> searchCities(String query) async {
    final searchCities = ref.read(searchCitiesUseCaseProvider);
    
    state = state.copyWith(
      status: CitiesSearchStatus.loading,
      errorMessage: null,
    );

    final result = await searchCities(query);
    
    result.fold(
      (failure) => state = state.copyWith(
        status: CitiesSearchStatus.error,
        errorMessage: failure.toString(),
      ),
      (cities) => state = state.copyWith(
        status: CitiesSearchStatus.success,
        cities: cities,
      ),
    );
  }

  void clearResults() {
    state = const CitiesSearchState();
  }
}

// Flight details state
enum FlightDetailsStatus { initial, loading, success, error }

@freezed
class FlightDetailsState with _$FlightDetailsState {
  const factory FlightDetailsState({
    @Default(FlightDetailsStatus.initial) FlightDetailsStatus status,
    Flight? flight,
    String? errorMessage,
  }) = _FlightDetailsState;
}

@riverpod
class FlightDetails extends _$FlightDetails {
  @override
  FlightDetailsState build() {
    return const FlightDetailsState();
  }

  Future<void> getFlightDetails(String flightId) async {
    final getFlightDetails = ref.read(getFlightDetailsUseCaseProvider);
    
    state = state.copyWith(
      status: FlightDetailsStatus.loading,
      errorMessage: null,
    );

    final result = await getFlightDetails(flightId);
    
    result.fold(
      (failure) => state = state.copyWith(
        status: FlightDetailsStatus.error,
        errorMessage: failure.toString(),
      ),
      (flight) => state = state.copyWith(
        status: FlightDetailsStatus.success,
        flight: flight,
      ),
    );
  }

  void clearDetails() {
    state = const FlightDetailsState();
  }
}