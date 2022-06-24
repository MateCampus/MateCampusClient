class NotificationZC {
  final int type;
  final String loginId;
  final String userNickname;
  String? imageUrl;
  DateTime createdAt;

  NotificationZC(
      {required this.type,
      required this.loginId,
      required this.userNickname,
      this.imageUrl,
      required this.createdAt});

//필요없을지도..?
  factory NotificationZC.fromJson(Map<String, dynamic> json) {
    return NotificationZC(
        type: json['type'],
        loginId: json['loginId'],
        userNickname: json['userNickname'],
        createdAt: DateTime.parse(json['createdAt']),
        imageUrl: json['imageUrls']);
  }
}
