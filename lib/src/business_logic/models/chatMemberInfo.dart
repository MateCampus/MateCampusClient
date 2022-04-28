class ChatMemberInfo {
  String loginId;
  String nickname;
  String imageUrl;

  ChatMemberInfo(
      {required this.loginId, required this.nickname, required this.imageUrl});

  factory ChatMemberInfo.fromJson(Map<String, dynamic> json) {
    return ChatMemberInfo(
        loginId: json['loginId'],
        nickname: json['nickname'],
        imageUrl: json['imageUrl']);
  }
}
