import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';
import 'package:gw_chat/core/model/country.dart';

///Получение всех стран
Future<List<Country>?> countriesRepository() async {
  try {
    final dio = Dio();
    final response = await dio.get(countriesUrl);
    final data = response.data as List<dynamic>;
    return List.generate(
      data.length,
      (index) => Country.fromJson(data[index] as Map<String, dynamic>),
    );
  } catch (e) {
    log(e.toString());
  }
  return null;
}
