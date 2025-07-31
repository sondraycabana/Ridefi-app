import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/city.dart';

@JsonSerializable()
class CityModel extends City {
  const CityModel({
    required super.code,
    required super.name,
    required super.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        code: json['code'] as String,
        name: json['name'] as String,
        country: json['country'] as String,
      );

  // Factory for Aviation Stack API airport response
  factory CityModel.fromAviationStackAirport(Map<String, dynamic> json) => CityModel(
        code: json['iata_code'] as String? ?? '',
        name: json['airport_name'] as String? ?? '',
        country: json['country_name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'country': country,
      };

  static CityModel fromEntity(City city) {
    return CityModel(
      code: city.code,
      name: city.name,
      country: city.country,
    );
  }
}