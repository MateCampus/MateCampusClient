class Comment {
  final int id;
  final String loginId;
  final String userNickname;
  final String body;
  bool deleted;
  final int parentId;
  List<Comment> children;
  DateTime? createdAt;

  Comment({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.body,
    required this.deleted,
    required this.parentId,
    required this.children,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      loginId: json['loginId'],
      userNickname: json['userNickname'],
      body: json['body'],
      deleted: json['deleted'],
      parentId: json['parentId'],
      children: json['children']
          .map<Comment>((json) => Comment.fromJson(json))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      // createdAt: DateTime(2021, 05, 05),
    );
  }
}
