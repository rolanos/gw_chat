import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';

///Получение всех пользователей за сегодня
Future<int?> todayActiveUsersStatRepository({int? countryId}) async {
  try {
    final dio = Dio();
    final response = await dio.get(todayTimeActiveUsers);
    final data = response.data as List<dynamic>;
    if (data.isNotEmpty) {
      return data.first['amount'] as int?;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}
