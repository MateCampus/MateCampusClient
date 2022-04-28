class ChatRoomMemberInfo {
  String roomId;
  String loginId;

  ChatRoomMemberInfo({required this.roomId, required this.loginId});

  factory ChatRoomMemberInfo.fromJson(Map<String, dynamic> json) {
    return ChatRoomMemberInfo(roomId: json['roomId'], loginId: json['loginId']);
  }
}
