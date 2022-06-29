import 'package:zamongcampus/src/business_logic/models/enums/notificationType.dart';

class NotificationZC {
  final NotificationType type;
  final int id;
  String? imageUrl;
  String? nickname;
  String? title;
  bool isUnRead;
  int? voiceRoomId;
  int? postId;
  DateTime createdAt;

  NotificationZC(
      {required this.type,
      required this.id,
      this.imageUrl,
      this.nickname,
      this.title,
      required this.isUnRead,
      this.voiceRoomId,
      this.postId,
      required this.createdAt});

//필요없을지도..?
  factory NotificationZC.fromJson(Map<String, dynamic> json) {
    return NotificationZC(
        type: NotificationType.values.byName(json['type'].toLowerCase()),
        id: json['id'],
        imageUrl: json['imageUrl'],
        nickname: json['nickname'],
        isUnRead: json['unRead'],
        title: json['title'],
        voiceRoomId: json['voiceRoomId'],
        postId: json['postId'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
