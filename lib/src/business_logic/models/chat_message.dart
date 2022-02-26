class ChatMessage {
  String roomId;
  String loginId;
  String text;
  ChatMessageType type;
  DateTime createdAt;

  ChatMessage({
    required this.roomId,
    required this.loginId,
    required this.text,
    required this.type,
    required this.createdAt,
  });
}

enum ChatMessageType {
  enter,
  talk,
}
