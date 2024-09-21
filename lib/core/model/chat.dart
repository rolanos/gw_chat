import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Chat extends Equatable {
  final String? chatName;
  final String? chatLink;
  final String? imgUrl;

  const Chat({
    required this.chatName,
    required this.chatLink,
    required this.imgUrl,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chatName: json["chat_name"],
        chatLink: json["chat_link"],
        imgUrl: json["img_url"],
      );

  Map<String, dynamic> toJson() => {
        "chat_name": chatName,
        "chat_link": chatLink,
        "img_url": imgUrl,
      };

  @override
  List<Object?> get props => [
        chatName,
        chatLink,
        imgUrl,
      ];
}
