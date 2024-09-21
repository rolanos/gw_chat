import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';
import 'package:gw_chat/core/model/city.dart';

///Все города по id страны
Future<List<City>?> citiesRepository({int? countyId}) async {
  try {
    final dio = Dio();
    String url = citiesUrl;
    if (countyId != null) {
      url += countyId.toString();
    } else {
      return null;
    }
    final response = await dio.get(url);
    final data = response.data as List<dynamic>;
    return List.generate(
      data.length,
      (index) => City.fromJson(data[index] as Map<String, dynamic>),
    );
  } catch (e) {
    log(e.toString());
  }
  return null;
}
