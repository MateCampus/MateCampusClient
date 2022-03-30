class Comment {
  final int id;
  final String loginId;
  final String userNickname;
  List<String>? userImageUrls;
  final String body;
  DateTime createdAt;
  List<Comment>? nestedComments;

  Comment({
    required this.id,
    required this.loginId,
    required this.userNickname,
    this.userImageUrls,
    required this.body,
    required this.createdAt,
    this.nestedComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        loginId: json['loginId'],
        userNickname: json['userNickname'],
        userImageUrls: json['userImageUrls']?.toList(),
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
        nestedComments: json['nestedComments']?.toList());
  }
}
