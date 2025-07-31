import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String code;
  final String name;
  final String country;

  const City({
    required this.code,
    required this.name,
    required this.country,
  });

  @override
  List<Object> get props => [code, name, country];

  @override
  String toString() => '$name ($code)';
}