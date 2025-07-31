# RideFi App

RideFi - A professional Flutter travel booking application for searching and booking flights, built with Clean Architecture and modern Flutter development practices.

## Features

### Core Functionality
- ✅ **Flight Search**: Search for flights by departure/arrival cities and date
- ✅ **City Autocomplete**: Smart city search with autocomplete suggestions
- ✅ **Flight Results**: Display comprehensive flight information including:
  - Airline name
  - Flight number and aircraft type
  - Departure and arrival times
  - Price in local currency
  - Direct/connecting flight information
  - Number of stops
- ✅ **Flight Details**: Detailed flight information screen with:
  - Complete route information
  - Stop cities (if applicable)
  - Aircraft details
  - Duration and pricing

### Technical Features
- ✅ **Clean Architecture**: Organized codebase with separation of concerns
- ✅ **Riverpod State Management**: Modern state management solution
- ✅ **Mock API**: Realistic flight data for testing
- ✅ **Error Handling**: Comprehensive error states and user feedback
- ✅ **Loading States**: Smooth loading indicators throughout the app
- ✅ **Unit Tests**: Comprehensive test coverage for business logic
- ✅ **Responsive Design**: Works on various screen sizes

## Architecture

The project follows Clean Architecture principles with the following structure:

```
lib/
├── core/
│   └── error/
│       └── failures.dart
├── features/
│   └── flight_search/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── flight_remote_data_source.dart
│       │   ├── models/
│       │   │   ├── city_model.dart
│       │   │   └── flight_model.dart
│       │   └── repositories/
│       │       └── flight_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── city.dart
│       │   │   ├── flight.dart
│       │   │   └── flight_search_params.dart
│       │   ├── repositories/
│       │   │   └── flight_repository.dart
│       │   └── usecases/
│       │       ├── get_flight_details.dart
│       │       ├── search_cities.dart
│       │       └── search_flights.dart
│       └── presentation/
│           ├── pages/
│           │   ├── flight_details_page.dart
│           │   └── flight_search_page.dart
│           ├── providers/
│           │   ├── flight_providers.dart
│           │   └── flight_search_notifier.dart
│           └── widgets/
│               ├── city_search_field.dart
│               └── flight_results_list.dart
└── main.dart
```

## Dependencies

### Core Dependencies
- `flutter_riverpod: ^2.6.1` - State management
- `riverpod_annotation: ^2.6.1` - Code generation for Riverpod
- `http: ^1.2.1` - HTTP client
- `dio: ^5.7.0` - Advanced HTTP client
- `intl: ^0.20.1` - Internationalization
- `equatable: ^2.0.5` - Object equality
- `dartz: ^0.10.1` - Functional programming utilities

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Linting rules
- `build_runner: ^2.4.13` - Code generation
- `json_serializable: ^6.8.0` - JSON serialization
- `riverpod_generator: ^2.6.2` - Riverpod code generation
- `mockito: ^5.4.4` - Mocking for tests

## Getting Started

### Prerequisites
- Flutter SDK (>=3.7.2)
- Dart SDK
- Android Studio or VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flight_search_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (if needed)
   ```bash
   dart run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```


## Usage

### Search for Flights
1. Open the app
2. Enter departure city (with autocomplete)
3. Enter arrival city (with autocomplete)
4. Select departure date
5. Tap "Search Flights"

### View Flight Details
1. From the search results, tap on any flight card
2. View comprehensive flight information
3. See route details, stops, and pricing

## Mock Data

The app uses mock data for Nigerian domestic flights including:
- **Cities**: Lagos, Abuja, Kano, Port Harcourt, Ibadan, Enugu, Calabar, Benin City, Yola, Maiduguri
- **Airlines**: Arik Air, United Nigeria, Air Peace
- **Aircraft**: Boeing 737, Embraer 145
- **Realistic pricing** in Nigerian Naira (NGN)

## Testing

The project includes comprehensive unit tests for:
- Domain use cases
- Repository implementations
- Business logic validation

Test files are located in the `test/` directory following the same structure as the main codebase.

## State Management

The app uses Riverpod for state management with the following providers:
- `flightSearchProvider` - Manages flight search state
- `citiesSearchProvider` - Handles city autocomplete
- `flightDetailsProvider` - Manages flight details view

## Error Handling

Comprehensive error handling includes:
- Network failures
- Server errors
- Data parsing errors
- User input validation
- Graceful fallbacks with user-friendly messages

