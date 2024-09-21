import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';
import 'package:gw_chat/core/model/user_list.dart';

///Получение всех пользователей за сегодня для графиков
///Если [countryId] == null - всех людей, если [countryId] != null по определенной стране
Future<UserList?> graphStatisticActiveUsersRepository({int? countryId}) async {
  try {
    final dio = Dio();
    var url = graphStatisticActiveUsers;
    if (countryId != null) {
      url += '/$countryId';
    }
    final response = await dio.get(url);
    final data = response.data as List<dynamic>;
    if (data.isNotEmpty) {
      final map = data.first as Map<String, dynamic>;
      if (map.containsKey('users')) {
        return UserList.fromJson(map);
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}
