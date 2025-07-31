class FlightFilters {
  final double? minPrice;
  final double? maxPrice;
  final List<String> selectedAirlines;
  final List<String> selectedSeatClasses;
  final bool? isDirect;
  final int? maxStops;
  final List<String> selectedDepartureTimeRanges;
  final List<String> selectedArrivalTimeRanges;

  const FlightFilters({
    this.minPrice,
    this.maxPrice,
    this.selectedAirlines = const [],
    this.selectedSeatClasses = const [],
    this.isDirect,
    this.maxStops,
    this.selectedDepartureTimeRanges = const [],
    this.selectedArrivalTimeRanges = const [],
  });

  FlightFilters copyWith({
    double? minPrice,
    double? maxPrice,
    List<String>? selectedAirlines,
    List<String>? selectedSeatClasses,
    bool? isDirect,
    int? maxStops,
    List<String>? selectedDepartureTimeRanges,
    List<String>? selectedArrivalTimeRanges,
  }) {
    return FlightFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedAirlines: selectedAirlines ?? this.selectedAirlines,
      selectedSeatClasses: selectedSeatClasses ?? this.selectedSeatClasses,
      isDirect: isDirect ?? this.isDirect,
      maxStops: maxStops ?? this.maxStops,
      selectedDepartureTimeRanges: selectedDepartureTimeRanges ?? this.selectedDepartureTimeRanges,
      selectedArrivalTimeRanges: selectedArrivalTimeRanges ?? this.selectedArrivalTimeRanges,
    );
  }

  bool get hasActiveFilters {
    return minPrice != null ||
           maxPrice != null ||
           selectedAirlines.isNotEmpty ||
           selectedSeatClasses.isNotEmpty ||
           isDirect != null ||
           maxStops != null ||
           selectedDepartureTimeRanges.isNotEmpty ||
           selectedArrivalTimeRanges.isNotEmpty;
  }

  int get activeFilterCount {
    int count = 0;
    if (minPrice != null || maxPrice != null) count++;
    if (selectedAirlines.isNotEmpty) count++;
    if (selectedSeatClasses.isNotEmpty) count++;
    if (isDirect != null) count++;
    if (maxStops != null) count++;
    if (selectedDepartureTimeRanges.isNotEmpty) count++;
    if (selectedArrivalTimeRanges.isNotEmpty) count++;
    return count;
  }

  FlightFilters clear() {
    return const FlightFilters();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlightFilters &&
           other.minPrice == minPrice &&
           other.maxPrice == maxPrice &&
           _listEquals(other.selectedAirlines, selectedAirlines) &&
           _listEquals(other.selectedSeatClasses, selectedSeatClasses) &&
           other.isDirect == isDirect &&
           other.maxStops == maxStops &&
           _listEquals(other.selectedDepartureTimeRanges, selectedDepartureTimeRanges) &&
           _listEquals(other.selectedArrivalTimeRanges, selectedArrivalTimeRanges);
  }

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    return Object.hash(
      minPrice,
      maxPrice,
      Object.hashAll(selectedAirlines),
      Object.hashAll(selectedSeatClasses),
      isDirect,
      maxStops,
      Object.hashAll(selectedDepartureTimeRanges),
      Object.hashAll(selectedArrivalTimeRanges),
    );
  }
}

class TimeRange {
  final String label;
  final int startHour;
  final int endHour;

  const TimeRange({
    required this.label,
    required this.startHour,
    required this.endHour,
  });

  static const List<TimeRange> departureTimeRanges = [
    TimeRange(label: 'Early Morning (6AM-12PM)', startHour: 6, endHour: 12),
    TimeRange(label: 'Afternoon (12PM-6PM)', startHour: 12, endHour: 18),
    TimeRange(label: 'Evening (6PM-12AM)', startHour: 18, endHour: 24),
    TimeRange(label: 'Night (12AM-6AM)', startHour: 0, endHour: 6),
  ];

  static const List<TimeRange> arrivalTimeRanges = [
    TimeRange(label: 'Early Morning (6AM-12PM)', startHour: 6, endHour: 12),
    TimeRange(label: 'Afternoon (12PM-6PM)', startHour: 12, endHour: 18),
    TimeRange(label: 'Evening (6PM-12AM)', startHour: 18, endHour: 24),
    TimeRange(label: 'Night (12AM-6AM)', startHour: 0, endHour: 6),
  ];
}