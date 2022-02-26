import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

import 'chat_message.dart';
import 'user.dart';

class VoiceRoom {
  final int id;
  final String title;
  final List<User> members;
  final List<ChatMessage> chatMessages;
  final List<Category> categories;
  DateTime createdAt;

  VoiceRoom(
      {required this.id,
      required this.title,
      required this.members,
      required this.chatMessages,
      required this.categories,
      required this.createdAt});

  factory VoiceRoom.fromJson(Map<String, dynamic> json) {
    return VoiceRoom(
        id: json['id'],
        title: json['title'],
        members: json['members'],
        chatMessages: json['chatMessages'],
        categories: json['categories'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
