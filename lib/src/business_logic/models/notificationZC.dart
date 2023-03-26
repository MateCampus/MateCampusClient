import 'package:zamongcampus/src/business_logic/models/enums/notificationType.dart';

class NotificationZC {
  final NotificationType type;
  final int id;
  final String imageUrl;
  final String nickname;
  final String body;
  bool isUnRead;
  int? voiceRoomId;
  int? postId;
  DateTime createdAt;

  NotificationZC(
      {required this.type,
      required this.id,
      required this.imageUrl,
      required this.nickname,
     required this.body,
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
        body: json['body'],
        voiceRoomId: json['voiceRoomId'],
        postId: json['postId'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
