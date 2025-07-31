import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/flight_search_notifier.dart';
import '../widgets/airport_dropdown.dart';
import '../pages/flight_results_page.dart';
import '../../domain/entities/flight_search_params.dart';
import '../../domain/entities/city.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/constants/app_constants.dart';

class FlightSearchPage extends ConsumerStatefulWidget {
  const FlightSearchPage({super.key});

  @override
  ConsumerState<FlightSearchPage> createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends ConsumerState<FlightSearchPage> {
  final _formKey = GlobalKey<FormState>();
  City? _selectedDepartureAirport;
  City? _selectedArrivalAirport;
  DateTime? _selectedDate;
  String _tripType = 'One way';
  bool _directFlightsOnly = false;
  bool _includeNearbyAirports = false;
  String _travelClass = 'Economy';
  int _passengers = 1;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _searchFlights() {
    if (_formKey.currentState!.validate() && 
        _selectedDate != null && 
        _selectedDepartureAirport != null && 
        _selectedArrivalAirport != null) {
      final params = FlightSearchParams(
        departureCity: _selectedDepartureAirport!.name,
        arrivalCity: _selectedArrivalAirport!.name,
        departureDate: _selectedDate!,
      );
      
      // Start the search
      ref.read(flightSearchProvider.notifier).searchFlights(params);
      
      // Navigate to results page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightResultsPage(searchParams: params),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final flightSearchState = ref.watch(flightSearchProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            children: [
              const SizedBox(height: AppConstants.spacingL),
              // Custom Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: AppConstants.spacingXL + AppConstants.spacingM),
                  Text(
                    'Search Flights',
                    style: AppTextStyles.h5,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 12),

                    AirportDropdown(
                      label: 'From',
                      hintText: 'From',
                      selectedAirport: _selectedDepartureAirport,
                      onChanged: (airport) {
                        setState(() {
                          _selectedDepartureAirport = airport;
                        });
                      },
                      validator: (airport) =>
                          airport == null ? 'Please select departure airport' : null,
                    ),
                    const SizedBox(height: 16),

                    AirportDropdown(
                      label: 'To',
                      hintText: 'To',
                      selectedAirport: _selectedArrivalAirport,
                      onChanged: (airport) {
                        setState(() {
                          _selectedArrivalAirport = airport;
                        });
                      },
                      validator: (airport) =>
                          airport == null ? 'Please select arrival airport' : null,
                    ),
                    const SizedBox(height: 16),

                    // Trip Type Selection
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color:  const Color(0xFFE8EDF5),
                        borderRadius: BorderRadius.circular(22),
                      
                      ),
                      child: Row(
                        children: [
                          _buildTripTypeButton('One way'),
                          _buildTripTypeButton('Round trip'),
                          _buildTripTypeButton('Multi-City'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDateField(),
                    const SizedBox(height: 24),

                    const Text(
                      'Optional Filters',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    _buildSwitchTile(
                      label: 'Direct Flights Only',
                      value: _directFlightsOnly,
                      onChanged: (v) => setState(() => _directFlightsOnly = v),
                    ),
                    _buildSwitchTile(
                      label: 'Include Nearby Airports',
                      value: _includeNearbyAirports,
                      onChanged: (v) => setState(() => _includeNearbyAirports = v),
                    ),
                    const SizedBox(height: 16),




                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Travel Class Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Travel Class',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            DropdownButton<String>(
                              value: _travelClass,
                              onChanged: (v) => setState(() => _travelClass = v!),
                              items: ['Economy', 'Premium Economy', 'Business', 'First']
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                  .toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Passengers Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Passengers',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: _passengers > 1
                                      ? () => setState(() => _passengers--)
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  '$_passengers',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: _passengers < 9
                                      ? () => setState(() => _passengers++)
                                      : null,
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),


                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: flightSearchState.status == FlightSearchStatus.loading
                            ? null
                            : _searchFlights,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: flightSearchState.status == FlightSearchStatus.loading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Text(
                          'Search Flights',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripTypeButton(String type) {
    final isSelected = _tripType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tripType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color.fromARGB(221, 250, 252, 253) : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            type,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black :  const Color(0xFF5C738A),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text('Departure Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          onTap: _selectDate,
          controller: TextEditingController(
            text: _selectedDate != null
                ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                : '',
          ),
          decoration: InputDecoration(
            hintText: 'Departure date',
            suffixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: const Color(0xFFE8EDF5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }



  Widget _buildSwitchTile({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Switch(
          value: value,
          onChanged: onChanged,
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.grey[200];
            }
            return Colors.grey[300];
          }),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}









