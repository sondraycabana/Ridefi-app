import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/flight_filters.dart';
import '../../domain/entities/flight.dart';

class FlightFiltersBottomSheet extends ConsumerStatefulWidget {
  final FlightFilters currentFilters;
  final List<Flight> allFlights;
  final Function(FlightFilters) onFiltersChanged;

  const FlightFiltersBottomSheet({
    super.key,
    required this.currentFilters,
    required this.allFlights,
    required this.onFiltersChanged,
  });

  @override
  ConsumerState<FlightFiltersBottomSheet> createState() => _FlightFiltersBottomSheetState();
}

class _FlightFiltersBottomSheetState extends ConsumerState<FlightFiltersBottomSheet> {
  late FlightFilters _tempFilters;
  late RangeValues _priceRange;
  double _minPrice = 0;
  double _maxPrice = 10000;

  @override
  void initState() {
    super.initState();
    _tempFilters = widget.currentFilters;
    _calculatePriceRange();
    _initializePriceRange();
  }

  void _calculatePriceRange() {
    if (widget.allFlights.isNotEmpty) {
      final prices = widget.allFlights.map((f) => f.price).toList()..sort();
      _minPrice = prices.first;
      _maxPrice = prices.last;
    }
  }

  void _initializePriceRange() {
    _priceRange = RangeValues(
      _tempFilters.minPrice ?? _minPrice,
      _tempFilters.maxPrice ?? _maxPrice,
    );
  }

  List<String> get _availableAirlines {
    return widget.allFlights
        .map((f) => f.airline)
        .toSet()
        .toList()
        ..sort();
  }

  List<String> get _availableSeatClasses {
    return widget.allFlights
        .map((f) => f.seatClass)
        .toSet()
        .toList()
        ..sort();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Flights',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _clearAllFilters,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range Filter
                  _buildPriceRangeFilter(),
                  const SizedBox(height: 30),

                  // Airlines Filter
                  _buildAirlinesFilter(),
                  const SizedBox(height: 30),

                  // Seat Class Filter
                  _buildSeatClassFilter(),
                  const SizedBox(height: 30),

                  // Stops Filter
                  _buildStopsFilter(),
                  const SizedBox(height: 30),

                  // Departure Time Filter
                  _buildTimeRangeFilter(
                    title: 'Departure Time',
                    selectedRanges: _tempFilters.selectedDepartureTimeRanges,
                    onChanged: (ranges) {
                      setState(() {
                        _tempFilters = _tempFilters.copyWith(
                          selectedDepartureTimeRanges: ranges,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 30),

                  // Arrival Time Filter
                  _buildTimeRangeFilter(
                    title: 'Arrival Time',
                    selectedRanges: _tempFilters.selectedArrivalTimeRanges,
                    onChanged: (ranges) {
                      setState(() {
                        _tempFilters = _tempFilters.copyWith(
                          selectedArrivalTimeRanges: ranges,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Apply button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters ${_tempFilters.hasActiveFilters ? '(${_tempFilters.activeFilterCount})' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${_priceRange.start.round()}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1976D2),
              ),
            ),
            Text(
              '\$${_priceRange.end.round()}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1976D2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RangeSlider(
          values: _priceRange,
          min: _minPrice,
          max: _maxPrice,
          divisions: 20,
          activeColor: const Color(0xFF1976D2),
          inactiveColor: Colors.grey[300],
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
              _tempFilters = _tempFilters.copyWith(
                minPrice: values.start,
                maxPrice: values.end,
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildAirlinesFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Airlines',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableAirlines.map((airline) {
            final isSelected = _tempFilters.selectedAirlines.contains(airline);
            return FilterChip(
              label: Text(airline),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  final airlines = List<String>.from(_tempFilters.selectedAirlines);
                  if (selected) {
                    airlines.add(airline);
                  } else {
                    airlines.remove(airline);
                  }
                  _tempFilters = _tempFilters.copyWith(selectedAirlines: airlines);
                });
              },
              selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF1976D2),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSeatClassFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seat Class',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableSeatClasses.map((seatClass) {
            final isSelected = _tempFilters.selectedSeatClasses.contains(seatClass);
            return FilterChip(
              label: Text(seatClass),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  final classes = List<String>.from(_tempFilters.selectedSeatClasses);
                  if (selected) {
                    classes.add(seatClass);
                  } else {
                    classes.remove(seatClass);
                  }
                  _tempFilters = _tempFilters.copyWith(selectedSeatClasses: classes);
                });
              },
              selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF1976D2),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStopsFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stops',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('Direct flights only'),
              selected: _tempFilters.isDirect == true,
              onSelected: (selected) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(
                    isDirect: selected ? true : null,
                  );
                });
              },
              selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF1976D2),
            ),
            FilterChip(
              label: const Text('Max 1 stop'),
              selected: _tempFilters.maxStops == 1,
              onSelected: (selected) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(
                    maxStops: selected ? 1 : null,
                    isDirect: null,
                  );
                });
              },
              selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF1976D2),
            ),
            FilterChip(
              label: const Text('Max 2 stops'),
              selected: _tempFilters.maxStops == 2,
              onSelected: (selected) {
                setState(() {
                  _tempFilters = _tempFilters.copyWith(
                    maxStops: selected ? 2 : null,
                    isDirect: null,
                  );
                });
              },
              selectedColor: const Color(0xFF1976D2).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF1976D2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeRangeFilter({
    required String title,
    required List<String> selectedRanges,
    required Function(List<String>) onChanged,
  }) {
    final timeRanges = title == 'Departure Time' 
        ? TimeRange.departureTimeRanges 
        : TimeRange.arrivalTimeRanges;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: timeRanges.map((timeRange) {
            final isSelected = selectedRanges.contains(timeRange.label);
            return CheckboxListTile(
              title: Text(timeRange.label),
              value: isSelected,
              onChanged: (selected) {
                final ranges = List<String>.from(selectedRanges);
                if (selected == true) {
                  ranges.add(timeRange.label);
                } else {
                  ranges.remove(timeRange.label);
                }
                onChanged(ranges);
              },
              activeColor: const Color(0xFF1976D2),
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }

  void _clearAllFilters() {
    setState(() {
      _tempFilters = const FlightFilters();
      _initializePriceRange();
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged(_tempFilters);
    Navigator.pop(context);
  }
}