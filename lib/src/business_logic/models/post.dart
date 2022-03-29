import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

class Post {
  final int id;
  final String loginId;
  final List<Category> categories; //포스트에 관심사 설정이 없을 수도 있음
  final String title;
  final String userNickname;
  final List<String> userImageUrls;
  final String body;
  DateTime createdAt;
  int likedCount;
  int viewCount;
  int? commentCount;
  List<String>? imageUrls;
  List<Comment>? comments;

  Post(
      {required this.id,
      required this.loginId,
      required this.categories,
      required this.title,
      required this.userNickname,
      required this.userImageUrls,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.viewCount,
      this.commentCount,
      this.imageUrls,
      this.comments});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        loginId: json['loginId'],
        categories: json['categories'],
        title: json['title'],
        userNickname: json['userNickname'],
        userImageUrls: json['userImageUrls'].toList(),
        body: json['body'],
        createdAt: DateTime.parse(json['createdAt']),
        likedCount: json['likedCount'],
        viewCount: json['viewCount'],
        commentCount: json['commentCount'],
        imageUrls: json['imageUrls']?.toList(),
        comments: json['comments']?.toList());
  }
}
