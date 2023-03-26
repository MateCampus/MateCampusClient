
class Comment {
  final int id;
  final String loginId;
  final String userNickname;
  final String? userCollegeName;
  final String userImageUrl;
  final String body;
  bool deleted;
  final int parentId;
  List<Comment>? children;
  DateTime? createdAt;
  int? postId;

  Comment(
      {required this.id,
      required this.loginId,
      required this.userNickname,
       this.userCollegeName,
      required this.userImageUrl,
      required this.body,
      required this.deleted,
      required this.parentId,
      required this.children,
      this.createdAt,
      this.postId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        loginId: json['loginId'],
        userNickname: json['userNickname'] ?? "",
        userCollegeName: json['writerCollegeName'],
        userImageUrl: json['writerProfileImageUrl']?? "",
        body: json['body'],
        deleted: json['deleted'],
        parentId: json['parentId'],
        children: json['children']
            ?.map<Comment>((json) => Comment.fromJson(json))
            .toList(),
        createdAt: DateTime.parse(json['createdAt']),
        postId: json['postId']);
  }
}
