class Friend {
  final int id;
  final String loginId;
  final String? imageUrl;
  final String nickname;
  final String requestorLoginId;
  final FriendRequestStatus friendRequestStatus;

  Friend(
      {required this.id,
      required this.loginId,
      this.imageUrl,
      required this.nickname,
      required this.requestorLoginId,
      required this.friendRequestStatus});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
        id: json['id'],
        loginId: json['loginId'],
        imageUrl: json['imageUrl'],
        nickname: json['nickname'],
        requestorLoginId: json['requestorLoginId'],
        friendRequestStatus: FriendRequestStatus.values.byName(json['status']));
  }
}

enum FriendRequestStatus {
  NONE,
  UNACCEPTED,
  ACCEPTED,
}
