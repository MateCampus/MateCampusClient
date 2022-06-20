import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

import 'enums/categoryCode.dart';

class Post {
  final int id;
  final String loginId;
  final String userNickname;
  final String title;
  final String body;
  DateTime createdAt;
  int likedCount;
  List<String> imageUrls;
  int viewCount;
  int commentCount;
  List<Comment>? comments;
  final List<CategoryCode>? categories; //포스트에 관심사 설정이 없을 수도 있음

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
      required this.imageUrls,
      this.comments});

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
        imageUrls: json['imageUrls']
            .map<String>((imageUrl) => imageUrl.toString())
            .toList(),
        comments: json['comments']
            ?.map<Comment>((comment) => Comment.fromJson(comment))
            .toList());
  }
}
