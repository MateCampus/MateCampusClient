import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

class Post {
  final int id;
  final String loginId;
  final List<Category> categories; //포스트에 관심사 설정이 없을 수도 있음
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
      required this.categories,
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
        categories: json['categories'],
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
