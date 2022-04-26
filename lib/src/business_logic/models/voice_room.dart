import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

import 'chat_message.dart';
import 'user.dart';

class VoiceRoom {
  final int id;
  String title;
  List<User> members;
  List<ChatMessage>? chatMessages;
  List<Category> categories;
  DateTime createdAt;
  VoiceRoomType type;
  bool? collegeOnly;
  bool? majorOnly;

  VoiceRoom(
      {required this.id,
      required this.title,
      required this.members,
      this.chatMessages,
      required this.categories,
      required this.createdAt,
      required this.type,
      this.collegeOnly,
      this.majorOnly});

  factory VoiceRoom.fromJson(Map<String, dynamic> json) {
    return VoiceRoom(
        id: json['id'],
        title: json['title'],
        members: json['members'],
        chatMessages: json['chatMessages'],
        categories: json['categories'],
        createdAt: DateTime.parse(json['createdAt']),
        type: json['']);
  }
}

enum VoiceRoomType { PUBLIC, PRIVATE }
