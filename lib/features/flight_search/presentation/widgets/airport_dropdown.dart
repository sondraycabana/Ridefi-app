import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/city.dart';
import '../providers/flight_search_notifier.dart';

class AirportDropdown extends ConsumerStatefulWidget {
  final String label;
  final String hintText;
  final City? selectedAirport;
  final Function(City?) onChanged;
  final String? Function(City?)? validator;

  const AirportDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.selectedAirport,
    required this.onChanged,
    this.validator,
  });

  @override
  ConsumerState<AirportDropdown> createState() => _AirportDropdownState();
}

class _AirportDropdownState extends ConsumerState<AirportDropdown> {
  final TextEditingController _controller = TextEditingController();
  bool _isDropdownOpen = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.selectedAirport?.name ?? '';
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isDropdownOpen = false;
        });
      }
    });
    
    // Load airports when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAirports();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _loadAirports() {
    // Use the cities search provider to get airports
    // Load all airports initially (empty string will return first 50)
    ref.read(citiesSearchProvider.notifier).searchCities('');
  }

  void _onTextChanged(String value) {
    setState(() {
      _isDropdownOpen = true; // Always show dropdown when user types
    });
    
    // Search for airports based on user input
    ref.read(citiesSearchProvider.notifier).searchCities(value);
  }

  void _selectAirport(City airport) {
    setState(() {
      _controller.text = '${airport.name} (${airport.code})';
      _isDropdownOpen = false;
    });
    widget.onChanged(airport);
    _focusNode.unfocus();
  }

  Widget _buildDropdownContent(CitiesSearchState citiesState) {
    if (citiesState.status == CitiesSearchStatus.loading) {
      return const SizedBox(
        height: 60,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (citiesState.status == CitiesSearchStatus.error) {
      return SizedBox(
        height: 60,
        child: Center(
          child: Text(
            'Error loading airports: ${citiesState.errorMessage ?? 'Unknown error'}',
            style: const TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (citiesState.cities.isEmpty) {
      return const SizedBox(
        height: 60,
        child: Center(
          child: Text(
            'No airports found',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: citiesState.cities.length > 10 
          ? 10 
          : citiesState.cities.length,
      itemBuilder: (context, index) {
        final airport = citiesState.cities[index];
        return ListTile(
          onTap: () => _selectAirport(airport),
          title: Text(
            airport.name,
            style: const TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            '${airport.code} • ${airport.country}',
            style: const TextStyle(fontSize: 12),
          ),
          dense: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final citiesState = ref.watch(citiesSearchProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _isDropdownOpen ? 260 : 60, // Provide space for dropdown
          child: Stack(
            clipBehavior: Clip.none, // Allow dropdown to overflow
            children: [
              TextFormField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: _onTextChanged,
                onTap: () {
                  setState(() {
                    _isDropdownOpen = true;
                  });
                  _loadAirports();
                },
                validator: widget.validator != null 
                    ? (value) => widget.validator!(widget.selectedAirport)
                    : null,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.keyboard_arrow_up, size: 18),
                      Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              if (_isDropdownOpen)
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildDropdownContent(citiesState),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (citiesState.status == CitiesSearchStatus.loading)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }
}