import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/flight_model.dart';
import '../models/city_model.dart';
import '../../domain/entities/flight_search_params.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights(FlightSearchParams params);
  Future<FlightModel> getFlightDetails(String flightId);
  Future<List<CityModel>> getCities();
  Future<List<CityModel>> searchCities(String query);
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://api.aviationstack.com/v1';
  static const String apiKey = '7247729bb1c7f470309b6de66e7ca739';

  FlightRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FlightModel>> searchFlights(FlightSearchParams params) async {
    try {
      // Format date for API (YYYY-MM-DD)
      final dateStr = '${params.departureDate.year}-${params.departureDate.month.toString().padLeft(2, '0')}-${params.departureDate.day.toString().padLeft(2, '0')}';
      
      final response = await client.get(
        Uri.parse('$baseUrl/flights?access_key=$apiKey&limit=50&flight_date=$dateStr'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> flightsData = jsonData['data'] ?? [];
        
        // Filter flights based on departure/arrival cities if specified
        List<FlightModel> flights = flightsData
            .map((flightJson) => FlightModel.fromAviationStack(flightJson))
            .where((flight) {
              // Basic filtering - in real app you'd want more sophisticated matching
              if (params.departureCity.isNotEmpty && params.arrivalCity.isNotEmpty) {
                return flight.departureCity.toLowerCase().contains(params.departureCity.toLowerCase()) ||
                       flight.departureAirport.toLowerCase().contains(params.departureCity.toLowerCase()) ||
                       flight.arrivalCity.toLowerCase().contains(params.arrivalCity.toLowerCase()) ||
                       flight.arrivalAirport.toLowerCase().contains(params.arrivalCity.toLowerCase());
              }
              return true;
            })
            .toList();
        
        // If no matching flights found, return some sample flights
        if (flights.isEmpty) {
          return _getMockFlights(params);
        }
        
        return flights;
      } else {
        throw Exception('Failed to load flights: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _getMockFlights(params);
    }
  }

  @override
  Future<FlightModel> getFlightDetails(String flightId) async {
    // Mock implementation
    final flights = _getMockFlights(FlightSearchParams(
      departureCity: 'Lagos',
      arrivalCity: 'Abuja',
      departureDate: DateTime.now(),
    ));
    return flights.firstWhere((flight) => flight.id == flightId);
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      print('🛩️ Fetching airports from API...');
      final response = await client.get(
        Uri.parse('$baseUrl/airports?access_key=$apiKey&limit=100'),
        headers: {'Content-Type': 'application/json'},
      );

      print('🛩️ API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        // Check for API errors (like quota exceeded)
        if (jsonData.containsKey('error')) {
          final error = jsonData['error'];
          print('🛩️ API Error: ${error['code']} - ${error['message']}');
          throw Exception('API Error: ${error['message']}');
        }
        
        final List<dynamic> airportsData = jsonData['data'] ?? [];
        
        print('🛩️ Found ${airportsData.length} airports in API response');
        
        final cities = airportsData
            .map((airportJson) => CityModel.fromAviationStackAirport(airportJson))
            .where((city) => city.code.isNotEmpty && city.name.isNotEmpty)
            .toList();
            
        print('🛩️ Processed ${cities.length} valid airports');
        return cities;
      } else {
        print('🛩️ API request failed with status: ${response.statusCode}');
        throw Exception('Failed to load airports: ${response.statusCode}');
      }
    } catch (e) {
      print('🛩️ Error fetching airports: $e');
      print('🛩️ Falling back to mock data');
      // Fallback to mock data if API fails
      return _getMockCities();
    }
  }

  @override
  Future<List<CityModel>> searchCities(String query) async {
    print('🔍 Searching cities with query: "$query"');
    final cities = await getCities();
    
    // If query is empty, return all cities (limited to first 50 for performance)
    if (query.isEmpty) {
      final result = cities.take(50).toList();
      print('🔍 Returning ${result.length} airports for empty query');
      return result;
    }
    
    // Otherwise filter based on query
    final result = cities
        .where((city) =>
            city.name.toLowerCase().contains(query.toLowerCase()) ||
            city.code.toLowerCase().contains(query.toLowerCase()))
        .take(20) // Limit search results
        .toList();
        
    print('🔍 Found ${result.length} airports matching "$query"');
    return result;
  }

  List<FlightModel> _getMockFlights(FlightSearchParams params) {
    return [
      FlightModel(
        id: '1',
        flightNumber: 'AA2351',
        airline: 'Arik Air',
        airlineLogoUrl: null,
        aircraft: 'Boeing 737',
        departureCity: params.departureCity,
        arrivalCity: params.arrivalCity,
        departureAirport: 'LOS',
        arrivalAirport: 'ABV',
        departureTime: DateTime.now().add(const Duration(hours: 2)),
        arrivalTime: DateTime.now().add(const Duration(hours: 3, minutes: 45)),
        price: 45000.0,
        currency: 'NGN',
        duration: const Duration(hours: 1, minutes: 45),
        stops: 0,
        stopCities: [],
        isDirect: true,
        seatClass: 'Economy',
        checkedBags: 1,
        carryOnBags: 1,
        cancellationPolicy: 'Free cancellation up to 24 hours before departure',
        refundPolicy: 'Refundable with 15% processing fee',
        hasWiFi: true,
        hasMeals: true,
        hasEntertainment: false,
      ),
      FlightModel(
        id: '2',
        flightNumber: 'UB1234',
        airline: 'United Nigeria',
        airlineLogoUrl: null,
        aircraft: 'Embraer 145',
        departureCity: params.departureCity,
        arrivalCity: params.arrivalCity,
        departureAirport: 'LOS',
        arrivalAirport: 'ABV',
        departureTime: DateTime.now().add(const Duration(hours: 4)),
        arrivalTime: DateTime.now().add(const Duration(hours: 6)),
        price: 38000.0,
        currency: 'NGN',
        duration: const Duration(hours: 2),
        stops: 1,
        stopCities: ['Kano'],
        isDirect: false,
        seatClass: 'Economy',
        checkedBags: 1,
        carryOnBags: 1,
        cancellationPolicy: 'Non-refundable after 48 hours',
        refundPolicy: 'No refund policy',
        hasWiFi: false,
        hasMeals: false,
        hasEntertainment: true,
      ),
      FlightModel(
        id: '3',
        flightNumber: 'AA5678',
        airline: 'Air Peace',
        airlineLogoUrl: null,
        aircraft: 'Boeing 737',
        departureCity: params.departureCity,
        arrivalCity: params.arrivalCity,
        departureAirport: 'LOS',
        arrivalAirport: 'ABV',
        departureTime: DateTime.now().add(const Duration(hours: 6)),
        arrivalTime: DateTime.now().add(const Duration(hours: 7, minutes: 30)),
        price: 42000.0,
        currency: 'NGN',
        duration: const Duration(hours: 1, minutes: 30),
        stops: 0,
        stopCities: [],
        isDirect: true,
        seatClass: 'Business',
        checkedBags: 2,
        carryOnBags: 1,
        cancellationPolicy: 'Free cancellation up to 2 hours before departure',
        refundPolicy: 'Fully refundable',
        hasWiFi: true,
        hasMeals: true,
        hasEntertainment: true,
      ),
    ];
  }

  List<CityModel> _getMockCities() {
    return const [
      // Nigerian Airports
      CityModel(code: 'LOS', name: 'Murtala Muhammed International Airport', country: 'Nigeria'),
      CityModel(code: 'ABV', name: 'Nnamdi Azikiwe International Airport', country: 'Nigeria'),
      CityModel(code: 'KAN', name: 'Mallam Aminu Kano International Airport', country: 'Nigeria'),
      CityModel(code: 'PHC', name: 'Port Harcourt International Airport', country: 'Nigeria'),
      CityModel(code: 'IBA', name: 'Ibadan Airport', country: 'Nigeria'),
      CityModel(code: 'ENU', name: 'Akanu Ibiam International Airport', country: 'Nigeria'),
      CityModel(code: 'CBQ', name: 'Margaret Ekpo International Airport', country: 'Nigeria'),
      CityModel(code: 'BNI', name: 'Benin Airport', country: 'Nigeria'),
      CityModel(code: 'YOL', name: 'Yola Airport', country: 'Nigeria'),
      CityModel(code: 'MIU', name: 'Maiduguri International Airport', country: 'Nigeria'),
      
      // International Airports
      CityModel(code: 'JFK', name: 'John F. Kennedy International Airport', country: 'United States'),
      CityModel(code: 'LAX', name: 'Los Angeles International Airport', country: 'United States'),
      CityModel(code: 'LHR', name: 'London Heathrow Airport', country: 'United Kingdom'),
      CityModel(code: 'CDG', name: 'Charles de Gaulle Airport', country: 'France'),
      CityModel(code: 'DXB', name: 'Dubai International Airport', country: 'United Arab Emirates'),
      CityModel(code: 'IST', name: 'Istanbul Airport', country: 'Turkey'),
      CityModel(code: 'DOH', name: 'Hamad International Airport', country: 'Qatar'),
      CityModel(code: 'CAI', name: 'Cairo International Airport', country: 'Egypt'),
      CityModel(code: 'CPT', name: 'Cape Town International Airport', country: 'South Africa'),
      CityModel(code: 'JNB', name: 'O.R. Tambo International Airport', country: 'South Africa'),
      CityModel(code: 'ADD', name: 'Addis Ababa Bole International Airport', country: 'Ethiopia'),
      CityModel(code: 'NBO', name: 'Jomo Kenyatta International Airport', country: 'Kenya'),
      CityModel(code: 'ACC', name: 'Kotoka International Airport', country: 'Ghana'),
      CityModel(code: 'DKR', name: 'Blaise Diagne International Airport', country: 'Senegal'),
      CityModel(code: 'CAS', name: 'Mohammed V International Airport', country: 'Morocco'),
    ];
  }
}