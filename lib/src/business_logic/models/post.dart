class Post {
  final int id;
  final String loginId;
  final String userNickname;
  final String body;
  DateTime createdAt;
  int likedCount;
  List<dynamic>? imageUrls;

  Post(
      {required this.id,
      required this.loginId,
      required this.userNickname,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      this.imageUrls});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        loginId: json['loginId'],
        userNickname: json['userNickname'],
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
        likedCount: json['likedCount'],
        imageUrls: json['imageUrls']?.toList());
  }
}
