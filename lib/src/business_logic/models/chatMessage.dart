enum MessageType { enter, talk, exit, update }

class ChatMessage {
  String roomId;
  String loginId;
  String text;
  MessageType type;
  DateTime createdAt;

  ChatMessage({
    required this.roomId,
    required this.loginId,
    required this.text,
    required this.type,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        roomId: json['roomId'],
        loginId: json['loginId'],
        text: json['text'],
        type: json['type'],
        createdAt: DateTime.parse(json["createdAt"]));
  }

  factory ChatMessage.fromJsonRoomId(Map<String, dynamic> json, String roomId) {
    return ChatMessage(
        roomId: roomId,
        loginId: json['loginId'],
        text: json['text'],
        type: json['type'],
        createdAt: DateTime.parse(json["createdAt"]));
  }
}
