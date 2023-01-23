import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'enums/postCategoryCode.dart';

class Post {
  final int id;
  final String loginId;
  final String userNickname;
  final CollegeCode? userCollegeCode;
  final String userImageUrl;
  final String body;
  DateTime createdAt;
  int likedCount;
  List<String> imageUrls;
  int viewCount;
  int commentCount;
  List<Comment>? comments;
  List<PostCategoryCode>? postCategoryCodes;
  bool? liked;

  Post(
      {required this.id,
      required this.loginId,
      required this.userNickname,
      this.userCollegeCode,
      required this.userImageUrl,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.imageUrls,
      required this.viewCount,
      required this.commentCount,
      this.comments,
      this.postCategoryCodes,
      this.liked});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        loginId: json['loginId'],
        postCategoryCodes: json['postCategoryCodes']
            ?.map<PostCategoryCode>((postCategoryCode) =>
                PostCategoryCode.values.byName(postCategoryCode.toLowerCase()))
            .toList(),
        userNickname: json['userNickname'],
        userCollegeCode: json['writerCollegeCode'] != null
            ? CollegeCode.values.byName(json['writerCollegeCode'].toLowerCase())
            : null,
        userImageUrl: json['writerProfileImageUrl'],
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
            .toList(),
        liked: json['liked']);
  }
}
