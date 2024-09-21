import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';

///Пингуем сервер. Если просто заход в приложение countryId = -1, когда переходим в страну - [countryId]
Future<bool> ping({int? countryId}) async {
  try {
    countryId ??= -1;
    final dio = Dio();
    final response = await dio.get(pingUrl + countryId.toString());
    return response.statusCode == HttpStatus.ok;
  } catch (e) {
    log(e.toString());
  }
  return false;
}
