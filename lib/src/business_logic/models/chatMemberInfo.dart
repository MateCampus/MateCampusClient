class ChatMemberInfo {
  int? id;
  String loginId;
  String nickname;
  String? imageUrl;

  ChatMemberInfo(
      {this.id,
      required this.loginId,
      required this.nickname,
      required this.imageUrl});

  factory ChatMemberInfo.fromJson(Map<String, dynamic> json) {
    return ChatMemberInfo(
        id: json['id'],
        loginId: json['loginId'],
        nickname: json['nickname'],
        imageUrl: json['imageUrl']);
  }
}
