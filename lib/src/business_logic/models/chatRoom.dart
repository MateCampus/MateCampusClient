class ChatRoom {
  final String roomId;
  String title; // 1:1이면 상대방이름, 단톡방이면 단톡방이름
  final String type;
  String lastMessage;
  DateTime lastMsgCreatedAt;
  String imageUrl;
  int unreadCount;

  ChatRoom(
      {required this.roomId,
      required this.title,
      required this.type,
      required this.lastMessage,
      required this.lastMsgCreatedAt,
      required this.imageUrl,
      required this.unreadCount});

  // TODO: 여기서 S3bucket 안 키면 에러 뜨는데 그거 잡기?
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        roomId: json['roomId'],
        title: json['title'],
        type: json['type'],
        lastMessage: json['lastMessage'],
        lastMsgCreatedAt: DateTime.parse(json['lastMsgCreatedAt']),
        imageUrl: json['imageUrl'],
        unreadCount: json['unreadCount']);
  }
}
