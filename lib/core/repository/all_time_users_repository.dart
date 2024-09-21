import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';

///Получение всех стран пользователей за все время
Future<int?> allTimeUsersRepository() async {
  try {
    final dio = Dio();
    final response = await dio.get(allTimeActiveUsers);
    final data = response.data as List<dynamic>;
    if (data.isNotEmpty) {
      final amount = (data.first as Map<String, dynamic>)['amount'];
      return amount as int?;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}
