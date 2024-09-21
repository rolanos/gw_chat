import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class City extends Equatable {
  final String? cityName;
  final String? ruCityName;
  final int? cityId;

  const City({
    required this.cityName,
    required this.ruCityName,
    required this.cityId,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityName: json["city_name"],
        ruCityName: json["ru_city_name"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "ru_city_name": ruCityName,
        "city_name": cityName,
        "city_id": cityId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "city_name": cityName,
        "city_id": cityId,
      };

  @override
  List<Object?> get props => [
        cityName,
        ruCityName,
        cityId,
      ];
}
