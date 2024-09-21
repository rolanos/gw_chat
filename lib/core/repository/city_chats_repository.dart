import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';
import 'package:gw_chat/core/model/chat.dart';

///Все чаты по id города
Future<List<Chat>?> allTimeUsersRepository(int cityUrl) async {
  try {
    final dio = Dio();
    final response = await dio.get(chatsUrl + cityUrl.toString());
    final data = response.data as List<dynamic>;
    return List.generate(
      data.length,
      (index) => Chat.fromJson(data[index] as Map<String, dynamic>),
    );
  } catch (e) {
    log(e.toString());
  }
  return null;
}
