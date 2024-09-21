import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Country extends Equatable {
  final String? countryName;
  final String? ruCountryName;
  final int? countryId;
  final String? wiki;
  final String? flag;

  const Country({
    required this.countryName,
    required this.ruCountryName,
    required this.countryId,
    required this.wiki,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryName: json["country_name"],
        ruCountryName: json["ru_country_name"],
        countryId: json["country_id"],
        wiki: json["wiki"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "country_name": countryName,
        "ru_country_name": ruCountryName,
        "country_id": countryId,
        "wiki": wiki,
        "flag": flag,
      };
  Map<String, dynamic> toJsonUpdate() => {
        "country_name": countryName,
        "country_id": countryId,
        "wiki": wiki,
        "flag": flag,
      };

  @override
  List<Object?> get props => [
        countryName,
        ruCountryName,
        countryId,
        wiki,
        flag,
      ];
}
