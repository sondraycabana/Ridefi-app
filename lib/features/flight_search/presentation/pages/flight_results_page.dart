import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/flight_search_notifier.dart';
import '../pages/flight_details_page.dart';
import '../../domain/entities/flight.dart';
import '../../domain/entities/flight_search_params.dart';
import '../widgets/flight_filters_bottom_sheet.dart';
import '../../../../shared/animations/custom_page_transition.dart';
import '../../../../shared/widgets/animated_background.dart';

class FlightResultsPage extends ConsumerStatefulWidget {
  final FlightSearchParams searchParams;

  const FlightResultsPage({super.key, required this.searchParams});

  @override
  ConsumerState<FlightResultsPage> createState() => _FlightResultsPageState();
}

class _FlightResultsPageState extends ConsumerState<FlightResultsPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final flightSearchState = ref.watch(flightSearchProvider);

    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Flights',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Flight route header with animations
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // From airport with slide animation
                Expanded(
                  child: MovingIllustrationWidget(
                    offset: const Offset(-50, 0),
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextWidget(
                          text: _getAirportCode(widget.searchParams.departureCity),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          delay: const Duration(milliseconds: 200),
                        ),
                        AnimatedTextWidget(
                          text: _getCityName(widget.searchParams.departureCity),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          delay: const Duration(milliseconds: 400),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Flight icon with bounce animation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: MovingIllustrationWidget(
                    offset: const Offset(0, -30),
                    duration: const Duration(milliseconds: 1000),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Image.asset(
                            'assets/images/plane-img.png',
                            height: 40,
                            width: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // To airport with slide animation
                Expanded(
                  child: MovingIllustrationWidget(
                    offset: const Offset(50, 0),
                    duration: const Duration(milliseconds: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AnimatedTextWidget(
                          text: _getAirportCode(widget.searchParams.arrivalCity),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          delay: const Duration(milliseconds: 300),
                        ),
                        AnimatedTextWidget(
                          text: _getCityName(widget.searchParams.arrivalCity),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          delay: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Date and passenger info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('E, MMM d • 1 Adult').format(widget.searchParams.departureDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                if (flightSearchState.filters.hasActiveFilters)
                  Text(
                    '${flightSearchState.displayFlights.length} of ${flightSearchState.flights.length} flights',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _showFiltersBottomSheet(context, flightSearchState),
                  child: Row(
                    children: [
                      Text(
                        flightSearchState.filters.hasActiveFilters
                            ? 'Sort & Filter (${flightSearchState.filters.activeFilterCount})'
                            : 'Sort & Filter',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: flightSearchState.filters.hasActiveFilters
                              ? const Color(0xFF1976D2)
                              : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      if (flightSearchState.filters.hasActiveFilters)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: TextButton(
                            onPressed: () {
                              ref.read(flightSearchProvider.notifier).clearFilters();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                            ),
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      Icon(
                        Icons.tune,
                        size: 20,
                        color: flightSearchState.filters.hasActiveFilters
                            ? const Color(0xFF1976D2)
                            : Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Flight results
          Expanded(
            child: _buildFlightResults(context, flightSearchState),
          ),
          
          // Page indicators
          if (flightSearchState.status == FlightSearchStatus.success && flightSearchState.displayFlights.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  flightSearchState.displayFlights.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.blue
                          : Colors.grey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlightResults(BuildContext context, FlightSearchState state) {
    switch (state.status) {
      case FlightSearchStatus.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Searching for flights...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );

      case FlightSearchStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      case FlightSearchStatus.success:
        if (state.displayFlights.isEmpty) {
          final hasActiveFilters = state.filters.hasActiveFilters;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasActiveFilters ? Icons.filter_list_off : Icons.search_off,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  hasActiveFilters 
                      ? 'No flights match your filters'
                      : 'No flights found',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                if (hasActiveFilters) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(flightSearchProvider.notifier).clearFilters();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear Filters'),
                  ),
                ],
              ],
            ),
          );
        }

        return Container(
          // height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: state.displayFlights.length,
            itemBuilder: (context, index) {
              final flight = state.displayFlights[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: MovingIllustrationWidget(
                  offset: Offset(0, 50 + (index * 20)),
                  duration: Duration(milliseconds: 600 + (index * 100)),
                  child: FlightResultCard(flight: flight),
                ),
              );
            },
          ),
        );

      default:
        return const Center(
          child: Text('Start searching for flights'),
        );
    }
  }

  String _getAirportCode(String cityName) {
    final match = RegExp(r'\(([^)]+)\)').firstMatch(cityName);
    if (match != null) {
      return match.group(1) ?? cityName.substring(0, 3).toUpperCase();
    }
    return cityName.substring(0, 3).toUpperCase();
  }

  String _getCityName(String cityName) {
    final match = RegExp(r'^([^(]+)').firstMatch(cityName);
    if (match != null) {
      return match.group(1)?.trim() ?? cityName;
    }
    return cityName;
  }

  void _showFiltersBottomSheet(BuildContext context, FlightSearchState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FlightFiltersBottomSheet(
        currentFilters: state.filters,
        allFlights: state.flights,
        onFiltersChanged: (filters) {
          ref.read(flightSearchProvider.notifier).updateFilters(filters);
        },
      ),
    );
  }
}

class FlightResultCard extends StatelessWidget {
  final Flight flight;

  const FlightResultCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E5E5A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              CustomPageTransition(
                child: FlightDetailsPage(flightId: flight.id),
                fromColor: const Color(0xFFD4E8DA),
                toColor: const Color(0xFFEAF7F1),
                duration: const Duration(milliseconds: 800),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row: Airline and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight.airline,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          flight.seatClass,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${_formatPrice(flight.price)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Flight route and times
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('h:mm a').format(flight.departureTime),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            flight.departureAirport,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Duration and stops
                    Column(
                      children: [
                        Text(
                          _formatDuration(flight.duration),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          flight.isDirect ? 'Direct' : '${flight.stops} stop${flight.stops > 1 ? 's' : ''}',
                          style: TextStyle(
                            color: flight.isDirect ? Colors.green[300] : Colors.orange[300],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('h:mm a').format(flight.arrivalTime),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            flight.arrivalAirport,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return NumberFormat('#,###').format(price);
    }
    return price.toStringAsFixed(0);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}










