import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gw_chat/core/api_url.dart';
import 'package:gw_chat/core/model/chat.dart';

///Все города по id страны
Future<List<Chat>?> chatRepository({int? cityId}) async {
  try {
    final dio = Dio();
    String url = chatsUrl;
    if (cityId != null) {
      url += cityId.toString();
    } else {
      return null;
    }
    final response = await dio.get(url);
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
