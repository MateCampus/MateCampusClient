class Post {
  final int id;
  final String loginId;
  final String category;
  final String title;
  final String userNickname;
  final String body;
  DateTime createdAt;
  int likedCount;
  int viewCount;
  int commentCount;
  List<dynamic>? imageUrls;

  Post(
      {required this.id,
      required this.loginId,
      required this.category,
      required this.title,
      required this.userNickname,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.viewCount,
      required this.commentCount,
      this.imageUrls});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        loginId: json['loginId'],
        category: json['category'],
        title: json['title'],
        userNickname: json['userNickname'],
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
        likedCount: json['likedCount'],
        viewCount: json['viewCount'],
        commentCount: json['commentCount'],
        imageUrls: json['imageUrls']?.toList());
  }
}
