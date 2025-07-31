// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flight_search_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FlightSearchState {
  FlightSearchStatus get status => throw _privateConstructorUsedError;
  List<Flight> get flights => throw _privateConstructorUsedError;
  List<Flight> get filteredFlights => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  FlightSearchParams? get lastSearchParams =>
      throw _privateConstructorUsedError;
  FlightFilters get filters => throw _privateConstructorUsedError;

  /// Create a copy of FlightSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightSearchStateCopyWith<FlightSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightSearchStateCopyWith<$Res> {
  factory $FlightSearchStateCopyWith(
          FlightSearchState value, $Res Function(FlightSearchState) then) =
      _$FlightSearchStateCopyWithImpl<$Res, FlightSearchState>;
  @useResult
  $Res call(
      {FlightSearchStatus status,
      List<Flight> flights,
      List<Flight> filteredFlights,
      String? errorMessage,
      FlightSearchParams? lastSearchParams,
      FlightFilters filters});
}

/// @nodoc
class _$FlightSearchStateCopyWithImpl<$Res, $Val extends FlightSearchState>
    implements $FlightSearchStateCopyWith<$Res> {
  _$FlightSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlightSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? flights = null,
    Object? filteredFlights = null,
    Object? errorMessage = freezed,
    Object? lastSearchParams = freezed,
    Object? filters = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FlightSearchStatus,
      flights: null == flights
          ? _value.flights
          : flights // ignore: cast_nullable_to_non_nullable
              as List<Flight>,
      filteredFlights: null == filteredFlights
          ? _value.filteredFlights
          : filteredFlights // ignore: cast_nullable_to_non_nullable
              as List<Flight>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSearchParams: freezed == lastSearchParams
          ? _value.lastSearchParams
          : lastSearchParams // ignore: cast_nullable_to_non_nullable
              as FlightSearchParams?,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as FlightFilters,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlightSearchStateImplCopyWith<$Res>
    implements $FlightSearchStateCopyWith<$Res> {
  factory _$$FlightSearchStateImplCopyWith(_$FlightSearchStateImpl value,
          $Res Function(_$FlightSearchStateImpl) then) =
      __$$FlightSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FlightSearchStatus status,
      List<Flight> flights,
      List<Flight> filteredFlights,
      String? errorMessage,
      FlightSearchParams? lastSearchParams,
      FlightFilters filters});
}

/// @nodoc
class __$$FlightSearchStateImplCopyWithImpl<$Res>
    extends _$FlightSearchStateCopyWithImpl<$Res, _$FlightSearchStateImpl>
    implements _$$FlightSearchStateImplCopyWith<$Res> {
  __$$FlightSearchStateImplCopyWithImpl(_$FlightSearchStateImpl _value,
      $Res Function(_$FlightSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlightSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? flights = null,
    Object? filteredFlights = null,
    Object? errorMessage = freezed,
    Object? lastSearchParams = freezed,
    Object? filters = null,
  }) {
    return _then(_$FlightSearchStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FlightSearchStatus,
      flights: null == flights
          ? _value._flights
          : flights // ignore: cast_nullable_to_non_nullable
              as List<Flight>,
      filteredFlights: null == filteredFlights
          ? _value._filteredFlights
          : filteredFlights // ignore: cast_nullable_to_non_nullable
              as List<Flight>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSearchParams: freezed == lastSearchParams
          ? _value.lastSearchParams
          : lastSearchParams // ignore: cast_nullable_to_non_nullable
              as FlightSearchParams?,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as FlightFilters,
    ));
  }
}

/// @nodoc

class _$FlightSearchStateImpl extends _FlightSearchState {
  const _$FlightSearchStateImpl(
      {this.status = FlightSearchStatus.initial,
      final List<Flight> flights = const [],
      final List<Flight> filteredFlights = const [],
      this.errorMessage,
      this.lastSearchParams,
      this.filters = const FlightFilters()})
      : _flights = flights,
        _filteredFlights = filteredFlights,
        super._();

  @override
  @JsonKey()
  final FlightSearchStatus status;
  final List<Flight> _flights;
  @override
  @JsonKey()
  List<Flight> get flights {
    if (_flights is EqualUnmodifiableListView) return _flights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flights);
  }

  final List<Flight> _filteredFlights;
  @override
  @JsonKey()
  List<Flight> get filteredFlights {
    if (_filteredFlights is EqualUnmodifiableListView) return _filteredFlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredFlights);
  }

  @override
  final String? errorMessage;
  @override
  final FlightSearchParams? lastSearchParams;
  @override
  @JsonKey()
  final FlightFilters filters;

  @override
  String toString() {
    return 'FlightSearchState(status: $status, flights: $flights, filteredFlights: $filteredFlights, errorMessage: $errorMessage, lastSearchParams: $lastSearchParams, filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightSearchStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._flights, _flights) &&
            const DeepCollectionEquality()
                .equals(other._filteredFlights, _filteredFlights) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastSearchParams, lastSearchParams) ||
                other.lastSearchParams == lastSearchParams) &&
            (identical(other.filters, filters) || other.filters == filters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_flights),
      const DeepCollectionEquality().hash(_filteredFlights),
      errorMessage,
      lastSearchParams,
      filters);

  /// Create a copy of FlightSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightSearchStateImplCopyWith<_$FlightSearchStateImpl> get copyWith =>
      __$$FlightSearchStateImplCopyWithImpl<_$FlightSearchStateImpl>(
          this, _$identity);
}

abstract class _FlightSearchState extends FlightSearchState {
  const factory _FlightSearchState(
      {final FlightSearchStatus status,
      final List<Flight> flights,
      final List<Flight> filteredFlights,
      final String? errorMessage,
      final FlightSearchParams? lastSearchParams,
      final FlightFilters filters}) = _$FlightSearchStateImpl;
  const _FlightSearchState._() : super._();

  @override
  FlightSearchStatus get status;
  @override
  List<Flight> get flights;
  @override
  List<Flight> get filteredFlights;
  @override
  String? get errorMessage;
  @override
  FlightSearchParams? get lastSearchParams;
  @override
  FlightFilters get filters;

  /// Create a copy of FlightSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightSearchStateImplCopyWith<_$FlightSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CitiesSearchState {
  CitiesSearchStatus get status => throw _privateConstructorUsedError;
  List<City> get cities => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CitiesSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CitiesSearchStateCopyWith<CitiesSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitiesSearchStateCopyWith<$Res> {
  factory $CitiesSearchStateCopyWith(
          CitiesSearchState value, $Res Function(CitiesSearchState) then) =
      _$CitiesSearchStateCopyWithImpl<$Res, CitiesSearchState>;
  @useResult
  $Res call(
      {CitiesSearchStatus status, List<City> cities, String? errorMessage});
}

/// @nodoc
class _$CitiesSearchStateCopyWithImpl<$Res, $Val extends CitiesSearchState>
    implements $CitiesSearchStateCopyWith<$Res> {
  _$CitiesSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CitiesSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? cities = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CitiesSearchStatus,
      cities: null == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<City>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CitiesSearchStateImplCopyWith<$Res>
    implements $CitiesSearchStateCopyWith<$Res> {
  factory _$$CitiesSearchStateImplCopyWith(_$CitiesSearchStateImpl value,
          $Res Function(_$CitiesSearchStateImpl) then) =
      __$$CitiesSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CitiesSearchStatus status, List<City> cities, String? errorMessage});
}

/// @nodoc
class __$$CitiesSearchStateImplCopyWithImpl<$Res>
    extends _$CitiesSearchStateCopyWithImpl<$Res, _$CitiesSearchStateImpl>
    implements _$$CitiesSearchStateImplCopyWith<$Res> {
  __$$CitiesSearchStateImplCopyWithImpl(_$CitiesSearchStateImpl _value,
      $Res Function(_$CitiesSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? cities = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CitiesSearchStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CitiesSearchStatus,
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<City>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CitiesSearchStateImpl implements _CitiesSearchState {
  const _$CitiesSearchStateImpl(
      {this.status = CitiesSearchStatus.initial,
      final List<City> cities = const [],
      this.errorMessage})
      : _cities = cities;

  @override
  @JsonKey()
  final CitiesSearchStatus status;
  final List<City> _cities;
  @override
  @JsonKey()
  List<City> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CitiesSearchState(status: $status, cities: $cities, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitiesSearchStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_cities), errorMessage);

  /// Create a copy of CitiesSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CitiesSearchStateImplCopyWith<_$CitiesSearchStateImpl> get copyWith =>
      __$$CitiesSearchStateImplCopyWithImpl<_$CitiesSearchStateImpl>(
          this, _$identity);
}

abstract class _CitiesSearchState implements CitiesSearchState {
  const factory _CitiesSearchState(
      {final CitiesSearchStatus status,
      final List<City> cities,
      final String? errorMessage}) = _$CitiesSearchStateImpl;

  @override
  CitiesSearchStatus get status;
  @override
  List<City> get cities;
  @override
  String? get errorMessage;

  /// Create a copy of CitiesSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CitiesSearchStateImplCopyWith<_$CitiesSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FlightDetailsState {
  FlightDetailsStatus get status => throw _privateConstructorUsedError;
  Flight? get flight => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of FlightDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightDetailsStateCopyWith<FlightDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightDetailsStateCopyWith<$Res> {
  factory $FlightDetailsStateCopyWith(
          FlightDetailsState value, $Res Function(FlightDetailsState) then) =
      _$FlightDetailsStateCopyWithImpl<$Res, FlightDetailsState>;
  @useResult
  $Res call({FlightDetailsStatus status, Flight? flight, String? errorMessage});
}

/// @nodoc
class _$FlightDetailsStateCopyWithImpl<$Res, $Val extends FlightDetailsState>
    implements $FlightDetailsStateCopyWith<$Res> {
  _$FlightDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlightDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? flight = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FlightDetailsStatus,
      flight: freezed == flight
          ? _value.flight
          : flight // ignore: cast_nullable_to_non_nullable
              as Flight?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlightDetailsStateImplCopyWith<$Res>
    implements $FlightDetailsStateCopyWith<$Res> {
  factory _$$FlightDetailsStateImplCopyWith(_$FlightDetailsStateImpl value,
          $Res Function(_$FlightDetailsStateImpl) then) =
      __$$FlightDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FlightDetailsStatus status, Flight? flight, String? errorMessage});
}

/// @nodoc
class __$$FlightDetailsStateImplCopyWithImpl<$Res>
    extends _$FlightDetailsStateCopyWithImpl<$Res, _$FlightDetailsStateImpl>
    implements _$$FlightDetailsStateImplCopyWith<$Res> {
  __$$FlightDetailsStateImplCopyWithImpl(_$FlightDetailsStateImpl _value,
      $Res Function(_$FlightDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FlightDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? flight = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$FlightDetailsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FlightDetailsStatus,
      flight: freezed == flight
          ? _value.flight
          : flight // ignore: cast_nullable_to_non_nullable
              as Flight?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FlightDetailsStateImpl implements _FlightDetailsState {
  const _$FlightDetailsStateImpl(
      {this.status = FlightDetailsStatus.initial,
      this.flight,
      this.errorMessage});

  @override
  @JsonKey()
  final FlightDetailsStatus status;
  @override
  final Flight? flight;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FlightDetailsState(status: $status, flight: $flight, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightDetailsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.flight, flight) || other.flight == flight) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, flight, errorMessage);

  /// Create a copy of FlightDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightDetailsStateImplCopyWith<_$FlightDetailsStateImpl> get copyWith =>
      __$$FlightDetailsStateImplCopyWithImpl<_$FlightDetailsStateImpl>(
          this, _$identity);
}

abstract class _FlightDetailsState implements FlightDetailsState {
  const factory _FlightDetailsState(
      {final FlightDetailsStatus status,
      final Flight? flight,
      final String? errorMessage}) = _$FlightDetailsStateImpl;

  @override
  FlightDetailsStatus get status;
  @override
  Flight? get flight;
  @override
  String? get errorMessage;

  /// Create a copy of FlightDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightDetailsStateImplCopyWith<_$FlightDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
